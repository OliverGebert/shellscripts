#!/bin/bash

# this script will list all paths from $PATH in seperate lines subsituting : with \n 

# evaluate script options
VERBOSE='false'
while getopts v OPTION
do
    case ${OPTION} in
        v) VERBOSE='true'; echo 'Verbose mode on' ;
        ?) echo 'unknown argument';
    esac
done

echo "The following paths are defined in PATH"
echo "$PATH" |sed 's/:/\n/g'
