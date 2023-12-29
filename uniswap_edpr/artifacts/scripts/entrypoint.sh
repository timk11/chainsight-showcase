#!/bin/bash
script_dir=$(dirname "$(readlink -f "$0")")

. "$script_dir/utils.sh"

set -e -o pipefail
trap 'on_error $BASH_SOURCE $LINENO "$BASH_COMMAND" "$@"' ERR

if [ $# -gt 1 ]; then
    echo "ERR: Too many arguments."
    exit 1
fi

if [ $# -eq 1 ]; then
    echo "Selected is '$1'"
    TARGETS=$1
else
    TARGETS=`cat $script_dir/targets.txt`
fi

IFS=$'\n'
while read target;
do
    echo "Run script for $target"
    . "$script_dir/components/$target.sh"
done << FILE
$TARGETS
FILE
