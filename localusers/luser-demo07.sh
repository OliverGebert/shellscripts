#!/bin/bash

# Demonstrate the use of shift and while loops.

# Dislay the first three oarameter
echo "Parameter1: ${1}"
echo "Parameter2: ${2}"
echo "Parameter3: ${3}"

# loop thrugh all paramters
while [[ "${#}" -gt 0 ]]
do
  echo "Number of parameters: ${#}"
  echo "P 1: ${1}"
  echo "P 2: ${2}"
  echo "P 3: ${3}"
  echo
  shift
done

