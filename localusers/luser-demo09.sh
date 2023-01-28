#!/bin/bash

# This scrip demonsatres the case statement

if [[ "${1}" = 'start' ]]
then
  echo "starting"
elif [[ "${1}" = 'stop' ]]
then
  echo "stopping"
else
  echo 'no match found' >&2
  exit 1
fi

