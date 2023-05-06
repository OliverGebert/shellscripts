#!/bin/bash

# this script will add all files of to the current repo
# this script will commit the files with a givem message text
# this script will push the comitted files to main

# provide usage statement and exit 1
usage(){
    echo "usage: ${0} [v] MESSAGE"
    echo "add, commit and push current repo for all files"
    echo "use given commit message"
    echo " -v .      be verbose"
    exit 1
}

# evaluate script options
VERBOSE='false'
while getopts v OPTION
do
    case ${OPTION} in
        v) VERBOSE='true'; echo 'Verbose mode on' ;;
        ?) echo 'unknown argument'; usage
    esac
done

# use OPTIND as pointer to next argument position and shift all arguments one position less to left to have non arguments as remainer
shift "$(( OPTIND -1 ))"

# check if at least one argument for commit message is given, exit if less than 1 argument with usage statement
if [[ "${#}" -lt 1 ]]
then
    usage
else
    MESSAGE=${1}
    echo $MESSAGE
fi

# provide git status
echo "*** git status:"
git status
if [[ "${?}" -eq 0 ]]
then
    echo "*** git status worked"
else
    echo "*** git status not work"
fi

# add all files to current repo
echo "*** git add ."
git add .

# commit files with given comment
echo "*** git commit -m ${MESSAGE}"
git commit -m "${MESSAGE}"

# push comitted files to main branch
echo "*** git push"
git push

