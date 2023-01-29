#!/bin/bash

# use functions to capsulate code blocks. log level is defined on input parameter for script. If value other than 1|2 is given only put MESSAGE to logger

log() {
    local MESSAGE="${@}"
    case ${VERBOSE} in
        1) echo "${MESSAGE}" ;;
        2) echo "$(date): ${MESSAGE}" ;;
        *) logger -t luser-demo10.sh "${MESSAGE}" ;;
    esac
}

backup() {
    # make sure file exists
    if [[ -f "${FILE}" ]]
    then
        local BACKUPFILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
        log "copying ${FILE} to ${BACKUPFILE}"
        # the exit status will be the exit status of cp as it is the last command
        cp -p ${FILE} ${BACKUPFILE}
    else
        log "copying ${FILE} to ${BACKUPFILE} failed."
        return 1
    fi
}

if [[ "${#}" -ge 2 ]]
then
    readonly VERBOSE="${1}"
    readonly FILE="${2}"
    backup
    if [[ "${?}" -eq 0 ]]
    then
        log "backup succeeded"
    else
        log "backup failed."
        exit 1
    fi
else
    readonly VERBOSE='1'
    log "not enough parameters"
    exit 1
fi
exit 0

