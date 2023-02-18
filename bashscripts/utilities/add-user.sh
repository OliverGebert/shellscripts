#!/bin/bash

# this script creates an account on the local system
# You will be prompted for the account name and password

# check script execution with superuser

# echo start of script and date as first lines for STD_ERR
echo -e "\tScript started on: $(date) " >&2

# test whether UID shows root priviledges, else exit 1
UID_TEST='0'
if [[ "${UID}" -ne "${UID_TEST}" ]]
then
    echo "You need to be root"
    echo -e "\tYour UID is ${UID}, not root, you need to execute this script with root. Script exits" >&2
    exit 1
fi

# test whether 2 parameters are entered for USER_NAME and COMMENT, else exit 1
PARAM_TEST='2'
if [[ "${#}" -ge "${PARAM_TEST}" ]]
then
    USER_NAME=${1}
    COMMENT=${2}
else
    echo "Missing arguments: USER_NAME COMMENT. Script exits"
    echo -e "\tMissing arguments, usage: ${0} USER_NAME COMMENT. Script exits." >&2
    exit 1
fi

# generate inital pasword with 10 chars
PASSWORD=$(echo "${RANDOM}${RANDOM}" | base64 | head -c10)

# create user and check if succeeded, otherwise exit script
useradd -c "${COMMENT}" -m ${USER_NAME} > /dev/null
if [[ "${?}" -ne 0 ]]
then
    echo "useradd comand failed. script exits."
    echo -e "\tuseradd -c ${COMMENT} -m ${USER_NAME} failed. Script exits" >&2
    exit 1
fi

# set passwd and check success, otherwise exit script
echo ${PASSWORD} | passwd --stdin ${USER_NAME} > /dev/null
if [[ "${?}" -ne 0 ]]
then
    echo "passwd command failed. script exits."
    echo -e "\tpasswd command failed. script exits." >&2
    exit 1
fi

# force pwd change on first login
passwd -e ${USER_NAME} > /dev/null

# display account details and host information, exit 0 successfully
echo -e "\nLogin: " ${USER_NAME} "\nComment: " ${COMMENT} "\nPASSWORD: " ${PASSWORD} "\nCreated on: " $(hostname -s) "\n"
exit 0