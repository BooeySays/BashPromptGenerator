#!/bin/bash

. bars.sh;
. errorcode.sh;

# BACKUP OF PS1
if [ ! $ps1 ]; then
    ps1=$PS1
fi

export PS1="\n$dirbar\n\`all_return\`$userhost"
