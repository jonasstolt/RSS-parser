#!/bin/bash

uri=$1             # URI of RSS Feed
lines=$2           # Number of headlines
titlenum=$3        # Number of extra titles

# Script start
# Require a URI, as a minimum
if [[ "$uri" == "" ]]; then
    echo "No URI specified, cannot continue!" >&2
    echo "Please read the script for more information" >&2
else
    # Set defaults if none specified
    if [[ $lines == "" ]]; then lines=5 ; fi
    if [[ $titlenum == "" ]]; then titlenum=2 ; fi

    # The actual work
    curl -s --connect-timeout 30 "$uri" |\
    sed -e 's/<\/title>/\n/g' |\
    grep -o '<title>.*' |\
    sed -e 's/<title>//' |\
    head -n $(($lines + $titlenum)) |\
    tail -n $(($lines)) |\
    awk -F ' - ' '{for (i=2; i<=NF; i++) printf "%s%s", $i, (i<NF?" - ":"\n")}'
fi
