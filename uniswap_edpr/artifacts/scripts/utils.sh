#!/bin/bash

function on_error()
{
    status=$?
    script=$1
    line=$2
    command=$3

    {
        # echo "Status: $status"
        echo "occured on $script [Line $line]"
        echo "command: $command"
    } 1>&2
}
