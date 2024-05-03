#!/bin/bash

x=$1
grep -io "s" <<<"$x" |wc -l
if [ $? -eq 0 ]; then
    echo "Command Executed Successfully"
else
    echo "Command Failed"
fi
