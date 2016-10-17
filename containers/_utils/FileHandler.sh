#!/bin/bash
set -e # bail on error

trap "rm -rf '/src/*' && rm -rf '/dist/*'" INT ERR EXIT

if [ "$TYPE" = "tar" ]; then
    rm -rf "/src/*"
    rm -rf "/dist/*"
    tar x -p -v -C "/$CONTAINER/src" --warning=no-timestamp >> "/logs/tar-$CONTAINER.log";
    $CMD_TAR "$@" >> "/logs/cmd-$CONTAINER.log"
    cd "/dist" && tar c -m --touch * --warning=no-timestamp
else
    echo `$CMD_BUFFER`;
fi
