#!/bin/bash

# this script creates an account on the local system
# You will be prompted for the account name and pwd

# check script execution with superuser

UID_TEST='0'
if [[ "${UID}" -ne "${UID_TEST}" ]]
then
  echo "Your UID is not root, you need to execute this script with root"
  exit 1
else
  echo "Your UID matches root: ${UID_TEST}."
fi


# ask for user name
read -p 'Enter the user name to create: ' USER_NAME


# ask for the real name
read -p 'Enter the name of the person who this account is for: ' COMMENT

# ask for the pwd
read -p 'Enter pwd to use for the account: ' PWD

# create user and check if succeeded, otherwise exit script
useradd -c "${COMMENT}" -m ${USER_NAME}
if [[ "${?}" -ne 0 ]]
then
  echo "useradd comand failed. script exits."
  exit 1
fi

# set passwd and check success, otherwise exit script
echo ${PWD} | passwd --stdin ${USER_NAME}
if [[ "${?}" -ne 0 ]]
then
  echo "passwd comand failed. script exits."
  exit 1
fi

# force pwd change on first login
passwd -e ${USER_NAME}

# display account details and host information
echo "Login: " ${USER_NAME} "Comment: " ${COMMENT} "PWD: " ${PWD} "Created on: " $(hostname -s)