#!/bin/bash

# display UID
# display if vagrant user or not

# display UID
echo "you have UID ${UID}"

# only show message, if UID != 1000
UID_TO_TEST_FOR='1000'
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
    echo "Your UID does not match ${UID_TO_TEST_FOR}."
    exit 1
else
    echo "Your UID matches ${UID_TO_TEST_FOR}."
fi

# Display USer Name
USER_NAME=$(id -un)		# assign result from command to variable

# Test if the command succeeded
if [[ "${?}" -ne 0 ]]		# get exit code from last command
then
    echo 'the id command did not execute successfully.'
    exit 1
fi
echo "Your username is ${USER_NAME}"

# test username matches user name to test for
USER_NAME_TO_TEST_FOR='vagrant'
if [[ "${USER_NAME}" = "${USER_NAME_TO_TEST_FOR}" ]]
then
    echo "Your username matches ${USER_NAME_TO_TEST_FOR}."
fi

exit 0

