#!/bin/bash
set -e # bail on error

trap "rm -rf '/$CONTAINER/src/*' && rm -rf '/$CONTAINER/dist/*'" INT ERR EXIT

if [ "$TYPE" = "tar" ]; then
    rm -rf "/$CONTAINER/src/*"
    rm -rf "/$CONTAINER/dist/*"
    tar x -p -v -C "/$CONTAINER/src" --warning=no-timestamp >> "/logs/tar-$CONTAINER.log";
    $CMD_TAR >> "/logs/cmd-$CONTAINER.log"
    cd "/$CONTAINER/dist" && tar c -m --touch * --warning=no-timestamp
else
    echo `$CMD_BUFFER`;
fi
