#!/bin/bash

# this script disables or deletes a user

# provide usage statement and exit 1
usage(){
    echo "usage as root: ${0} [vdra]" >&2
    echo "disables a user by defaul" >&2
    echo " -v .      be verbose" >&2
    echo " -d .      deletes the user" >&2
    echo " -r .      removes the home directory" >&2
    echo " -a .      archive the deleted home directory" >&2
    exit 1
}

# if in verbose mode add extra information on StdOut
verbose(){
    local MESSAGE="${@}"
    if [[ "$VERBOSE" = 'true' ]]
    then
        echo -e "-v $(date +%F): $MESSAGE"
    fi
}

# test whether UID shows root priviledges, else exit 1
UID_TEST='0'
if [[ "${UID}" -ne "${UID_TEST}" ]]
then
    echo -e "\tYour UID is ${UID}, not root, you need to execute this script with root. Script exits"
    usage
    exit 1
fi

# evaluate script options
while getopts vdra OPTION
do
    case ${OPTION} in
        v) VERBOSE='true'; verbose 'Verbose mode on' ;;
        d) USER_DELETE='true' ;;
        r) HOME_REMOVE='true' ;;
        a) ARCHIVE='true' ;;
        ?) verbose 'unknown argument'; usage
    esac
done

# use OPTIND as pointer to next argument position and shift all arguments one position less to left to have non arguments as remainer
shift "$(( OPTIND -1 ))"
# give error message if any more arguments are provided after the parsing of getops
if [[ "${#}" -lt 1 ]]
then
    verbose 'not enough arguments, no user given'
    usage
fi
# get next argument and define home directory
LOCAL_USER=${1}
HOMEDIR="/home/${LOCAL_USER}"
verbose "User provided: $LOCAL_USER"

# backup home directory if requested
if [[ ARCHIVE='true' ]]
then
    tar -zcf "BACKUP-${LOCAL_USER}.tgz" ${HOMEDIR}
    # todo: move .tgz to /archive folder
    # make sure tar worked
    if [[ "${?}" -eq 0 ]]
    then
        verbose "Archive for ${HOMEDIR} created"
    else
        echo "the archive of ${HOMEDIR} was not created" >&2
        exit 1
    fi
fi
if [[ HOME_REMOVE='true' ]]
then
    userdel -r ${LOCAL_USER}
    # make sure the user got deleted
    if [[ "${?}" -eq 0 ]]
    then
        verbose "the account ${LOCAL_USER} was deleted"
    else
        echo "the account ${LOCAL_USER} was not deleted" >&2
        exit 1
    fi
else
    chage -E 0 ${LOCAL_USER}
    if [[ "${?}" -eq 0 ]]
    then
        verbose "the account ${LOCAL_USER} was disabled"
    else
        echo "the account ${LOCAL_USER} was not disabled" >&2
        exit 1
    fi
fi

exit 0
