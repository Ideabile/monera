#!/bin/ash
set -e # bail on error

trap "rm -rf '/monera/src/*!(node_modules|package)' && rm -rf '/monera/dist/*'" EXIT TERM INT

if [ "$TYPE" = "tar" ]; then
    cd /monera/src && tar -xvp >> "/logs/tar-$CONTAINER.log";
    eval $CMD_TAR $@ >> "/logs/cmd-$CONTAINER.log";
    cd "/monera/dist" && tar -cmp --touch *
else
    echo $(eval $CMD_BUFFER);
fi
