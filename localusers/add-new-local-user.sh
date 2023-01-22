#!/bin/bash

# this script creates an account on the local system
# You will be prompted for the account name and password

# check script execution with superuser

UID_TEST='0'
if [[ "${UID}" -ne "${UID_TEST}" ]]
then
  echo "Your UID is not root, you need to execute this script with root"
  exit 1
else
  echo "Your UID matches root: ${UID_TEST}."
fi

PARAM_TEST='2'
if [[ "${#}" -ge "${PARAM_TEST}" ]]
then
  USER_NAME=${1}
  COMMENT=${2}
else
  echo "Usage: ${0} USER_NAME COMMENT"
  exit 1
fi

PASSWORD=$(echo "${RANDOM}${RANDOM}" | base64 | head -c10)

# create user and check if succeeded, otherwise exit script
useradd -c "${COMMENT}" -m ${USER_NAME}
if [[ "${?}" -ne 0 ]]
then
  echo "useradd comand failed. script exits."
  exit 1
fi

# set passwd and check success, otherwise exit script
echo ${PASSWORD} | passwd --stdin ${USER_NAME}
if [[ "${?}" -ne 0 ]]
then
  echo "passwd comand failed. script exits."
  exit 1
fi

# force pwd change on first login
passwd -e ${USER_NAME}

# display account details and host information
echo -e "\nLogin: " ${USER_NAME} "\nComment: " ${COMMENT} "\nPASSWORD: " ${PASSWORD} "\nCreated on: " $(hostname -s) "\n"