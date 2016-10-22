FROM monera-base

ENV CONTAINER="es6"


ADD "${CONTAINER_PATH}/$CONTAINER/package.json" "/monera/package.json"
RUN npm install

ENV PACKAGE="babel-cli"
ENV BIN="babel"
ENV BINPATH="/monera/node_modules/.bin/${BIN}"

ENV BINARGS_BUFFER="--presets es2015,stage-0"
ENV BINARGS_TAR="--out-dir /monera/dist"

ENV CMD_TAR="${BINPATH} /monera/src ${BINARGS_BUFFER} ${BINARGS_TAR}"
ENV CMD_BUFFER="${BINPATH} ${BINARGS_BUFFER}"

RUN touch /logs/tar-${COMTAINER}.log