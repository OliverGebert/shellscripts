#!/bin/bash

# let the script generate a password

# The user can set the pathword length with -l and ass a special character with -s
# verobose mode can be turned on with -v
# set default value for password length

LENGTH=48

usage(){
    echo "usage: ${0} [vs] [l length]" >&2
    echo "generate a random password"
    echo " -l LENGTH specify password length 8-16"
    echo " -s .      add special character"
    echo " -v .      be verbose"
    exit 1
}

verbose(){
    MESSAGE="${@}"
    if [[ "$VERBOSE" = 'true' ]]
    then
        echo "verbose: $MESSAGE"
    fi
}

# evaluate script options
while getopts vl:s OPTION
do
    case ${OPTION} in
        v) VERBOSE='true'; verbose 'Verbose mode on' ;;
        l) LENGTH="${OPTARG}" ;;
        s) USE_SPECIAL_CHAR='true' ;;
        ?) usage
    esac
done

# start actual password generation script
verbose 'Start generating a password'

if [[ $LENGTH -lt 8 ]]
then
    LENGTH=8
    verbose 'minimum password length set to 8'
fi
if [[ $LENGTH -gt 16 ]]
then
    LENGTH=16
    verbose 'maximum password set to 16'
fi

# generate random password
PASSWORD=$(echo "${RANDOM}${RANDOM}${RANDOM}" | base64 | head -c${LENGTH})

# append special character to generated password
if [[ "$USE_SPECIAL_CHAR" = 'true' ]]
then
    SPECIAL_CHAR=$(echo '#+?$=;:-' | fold -w1 | shuf | head -c1)
    PASSWORD="$PASSWORD$SPECIAL_CHAR"
fi

echo "Your new password is: $PASSWORD"
exit 0