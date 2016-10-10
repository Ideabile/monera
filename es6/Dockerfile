FROM monera-base

ENV CONTAINER="es6"

WORKDIR "/${CONTAINER}"

ADD "./$CONTAINER/package.json" "/${CONTAINER}/package.json"
RUN npm install

ENV PACKAGE="babel-cli"
ENV BIN="babel"
ENV BINPATH="/${CONTAINER}/node_modules/.bin/${BIN}"

ENV BINARGS_BUFFER="--presets es2015,stage-0"
ENV BINARGS_TAR="--out-dir /${CONTAINER}/dist"

ENV CMD_TAR="${BINPATH} /${CONTAINER}/src ${BINARGS_BUFFER} ${BINARGS_TAR}"
ENV CMD_BUFFER="${BINPATH} ${BINARGS_BUFFER}"

RUN mkdir /${CONTAINER}/src /${CONTAINER}/dist
RUN mkdir /logs && touch /logs/tar-${COMTAINER}.log