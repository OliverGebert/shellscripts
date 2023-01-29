#!/bin/bash

# use functions to capsulate code blocks. log level is defined on input parameter for script. If value other than 1|2 is given only put MESSAGE to logger

log() {
    local VERBOSE="${1}"
    shift # shift the parameter list one to the left
    local MESSAGE="${@}"
    case ${VERBOSE} in
        1) echo "${MESSAGE}" ;;
        2) echo "$(date): ${MESSAGE}" ;;
        *) logger -t luser-demo10.sh "${MESSAGE}" ;;
    esac
}

VERBOSITY="${1}"
log "${VERBOSITY}" 'Hello'
log "${VERBOSITY}" 'to this new function'


