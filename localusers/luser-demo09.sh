#!/bin/bash

# This scrip demonsatres the case statement

case ${1} in
    start|Start) echo "starting" ;;
    stop|Stop) echo "stopping" ;;
    halt) echo "halting" ;;
    Status|status|state|State) echo "status" ;;
    *)
        echo "wrong parameter" >&2
        exit 1
    ;;
esac

# emd of script