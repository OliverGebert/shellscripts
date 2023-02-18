#!/bin/bash

# analyse log file and provider all IP adresses, with more than 10 failed login atempts on any port

usage(){
    echo "scans a provided http log file for failed login attempts"
    echo "show-attacker.sh file"
    exit 1
}

LIMIT='10'

if [[ -f "${1}" ]]
then
    echo -e "Count\tIP\t\tLocation"
    cat "${1}" | grep Failed | awk -F "from " '{print $2}' | cut -d ' ' -f 1 | sort | uniq -c | sort -nr | while read COUNT IP
    do
        if [[ $COUNT -gt $LIMIT ]]
        then
            LOCATION=$(geoiplookup ${IP} | awk -F ', ' '{print $NF}')
            echo -e "$COUNT\t$IP\t$LOCATION"
        fi
    done
    exit 0
    # geoiplookup -f ip-attack.log
else
    usage
fi
