#!/bin/bash

# This scrip demonsatres the case statement

case ${1} in
    start|Start) echo "starting" ;;
    stop|Stop) echo "stopping" ;;
    Status|status|state|State) echo "status" ;;
    *)
        echo "wrong parameter" >&2
        exit 1
    ;;
esac
