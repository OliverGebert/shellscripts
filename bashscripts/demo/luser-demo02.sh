#!/bin/bash

# Display the UID and username of the user executing this script
# display whether the user is root or not

# Display the UID
echo "Your UID is ${UID}"

# Display the username
USER_NAME=$(id -un)
echo "Your user name is ${USER_NAME}"

# Display Root
if [[ "${UID}" -eq 0 ]]
then
  echo 'you are root'
else
  echo 'you are not root'
fi
