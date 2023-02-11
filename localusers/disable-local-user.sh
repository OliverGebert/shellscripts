#!/bin/bash

# this script disables or deletes a user

# provide usage statement and exit 1
usage(){
    echo "usage as root: ${0} [vdra] USER [USER]" >&2
    echo "disables a user by defaul" >&2
    echo "only changes users with UID greater or equal 1000"
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

# check if at least one argument is given, exit if less than 1 argument with usage statement
if [[ "${#}" -lt 1 ]]
then
    usage
fi

# evaluate script options
VERBOSE='false'
USER_DELETE='false'
HOME_DELETE=''
ARCHIVE='false'
while getopts vdra OPTION
do
    case ${OPTION} in
        v) VERBOSE='true'; verbose 'Verbose mode on' ;;
        d) USER_DELETE='true' ;;
        r) HOME_DELETE='-r' ;;
        a) ARCHIVE='true' ;;
        ?) verbose 'unknown argument'; usage
    esac
done

# use OPTIND as pointer to next argument position and shift all arguments one position less to left to have non arguments as remainer
shift "$(( OPTIND -1 ))"

# check if archive directory required and existent, if not create
if [[ "${ARCHIVE}" = 'true' ]]
then
    # set backup directory
    BACKDIR="/home/backup"
    # check if directory exists
    [[ ! -d "${BACKDIR}" ]] && mkdir "${BACKDIR}" || verbose "Archive directory exists"
fi

# while loop for all users which are given as arguments
while [[ "${#}" -ge 1 ]]
do
    # get next argument as user and define home directory
    LOCAL_USER=${1}
    # set homedirectory
    HOMEDIR="/home/${LOCAL_USER}"
    
    verbose "Archive: ${ARCHIVE}"
    verbose "Delete Home Dir: ${HOME_DELETE}"
    verbose "Delete User: ${USER_DELETE}"
    verbose "User provided: ${LOCAL_USER}"
    verbose "Backup Directory: ${BACKDIR}"
    verbose "Home Directory: ${HOMEDIR}"
    
    # check if LOCAL_USER has UID -ge 1000, else skip
    if [[ $(id -u "${LOCAL_USER}") -ge 1000 ]]
    then
        # optionally backup home directory if requested
        if [[ "$ARCHIVE" = 'true' ]]
        then
            tar -zcf "${BACKDIR}/BACKUP-${LOCAL_USER}.tgz" ${HOMEDIR} 2>/dev/null
            # make sure tar worked
            if [[ "${?}" -eq 0 ]]
            then
                echo "Archive ${BACKDIR}/BACKUP-${LOCAL_USER}.tgz for ${HOMEDIR} created"
            else
                echo "Archive ${BACKDIR}/BACKUP-${LOCAL_USER}.tgz for ${HOMEDIR} was not created" >&2
                exit 1
            fi
        fi
        # delete user if requested, else disable as default
        if [[ "$USER_DELETE" = 'true' ]]
        then
            # delete user and home directory if requested, else delete user only
            userdel ${HOME_DELETE} ${LOCAL_USER}
            # make sure rmdir worked
            if [[ "${?}" -eq 0 ]]
            then
                echo "the user ${LOCAL_USER} was deleted with option: ${HOME_DELETE}"
            else
                echo "the user ${LOCAL_USER} was not deleted" >&2
                exit 1
            fi
        else
            # reduce password change time to zero and disable account
            chage -E 0 ${LOCAL_USER}
            # make sure the chage command worked
            if [[ "${?}" -eq 0 ]]
            then
                echo "the account ${LOCAL_USER} was disabled"
            else
                echo "the account ${LOCAL_USER} was not disabled" >&2
                exit 1
            fi
        fi
    else
        echo "UID from user ${LOCAL_USER} is below 1000: $(id -u "${LOCAL_USER}") "
    fi
    echo "the ${LOCAL_USER} account handling is completed" >&2
    # get next parameter in the list of users
    shift 1
done

verbose 'no more arguments.'
exit 0
