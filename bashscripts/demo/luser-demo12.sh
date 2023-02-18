#!/bin/bash

# this script deletes a user

# run root

if [[ "${UID}" -ne 0 ]]
then
    echo "please run in root" >&2
    exit 1
fi

# assume the first argument is the user to delete

USER="${1}"

userdel -r ${USER}

# make sure the user got deleted

if [[ "${?}" -ne 0 ]]
then
    echo "the account ${USER} was not deleted" >&2
    exit 1
fi

echo "the account ${USER} was deleted, including the home dir"

exit 0

