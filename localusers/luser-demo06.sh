#!/bin/bash

# This script generates a random pwd for each user specified on the commadn line

# Display what the user typed on the command line
echo "you executed this command: ${0}"

# display the path and filename of the script

echo "you used $(dirname ${0}) as the path to the $(basename ${0}) script."

# tell the user how many arguments they passed in 
NUMBER_OF_PARAMS="${#}"
echo "you supplied ${NUMBER_OF_PARAMS} arguments on the command line."

# make sure they at least provide one argument

if [[ "${NUMBER_OF_PARAMS}" -lt 1 ]]
then
  echo "usage: ${0} USER_NAME [USER_NAME]..."
  exit 1
fi
# generate and disply a pwd for each parameter

for USER_NAME in "${@}" # @ creates a list of all parameters, whereas * would provide all parameters in concatenated in one argument
do
  PWD=$(date +%s%N | sha256sum | head -c48)
  echo "${USER_NAME}: ${PWD}"
done

