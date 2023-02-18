#!/bin/bash

# this script demonstrets I/O redirection

# redirect STDOUT to a file

FILE="/tmp/data"
head -n1 /etc/passwd > ${FILE}

# redirect STDIN to a program

read LINE < ${FILE}

# redirect STDOUT to a file using FD1, overwritng the file

head -n3 /etc/passwd 1> ${FILE}
echo
echo "LINE contains: ${LINE}"
cat ${FILE}

# Redirect STDERR to a file using FD2.

ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd /fakefile 2> ${ERR_FILE}
echo
echo "error_file contains:"
cat ${ERR_FILE}

# Redirect STDOUT and SDTERR to a file
head -n3 /etc/passwd /fakefile &> ${FILE}
echo
echo "FILE contains SDTOUT & STDERR:"
cat ${FILE}

# Redirect STDOUT & STDERR through a pipe
echo
echo "Pipe STDERR & STDOUT to cat -n"
head -n3 /etc/passwd /fakefile |& cat -n

# send output to STDERR
echo
echo "This is STDERR!" >&2

# Discard STDOUT
echo
echo "Discard STDOUT"
head -n3 /etc/passwd /fakefile > /dev/null

# Clean up
rm ${FILE} ${ERR_FILE} &> /dev/null

