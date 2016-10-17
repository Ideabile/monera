FROM monera-base

ENV CONTAINER="es6"

WORKDIR "/"

ADD "${CONTAINER_PATH}/$CONTAINER/package.json" "/package.json"
RUN npm install

ENV PACKAGE="babel-cli"
ENV BIN="babel"
ENV BINPATH="/node_modules/.bin/${BIN}"

ENV BINARGS_BUFFER="--presets es2015,stage-0"
ENV BINARGS_TAR="--out-dir /${CONTAINER}/dist"

ENV CMD_TAR="${BINPATH} /src ${BINARGS_BUFFER} ${BINARGS_TAR}"
ENV CMD_BUFFER="${BINPATH} ${BINARGS_BUFFER}"

RUN mkdir /src /dist
RUN mkdir /logs && touch /logs/tar-${COMTAINER}.log