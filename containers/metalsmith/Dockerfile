FROM monera-base

ENV CONTAINER="metalsmith"
ENV PACKAGE=$CONTAINER
ENV BIN=$PACKAGE

WORKDIR /${BIN}

ADD ${CONTAINER_PATH}/${BIN}/package.json /${BIN}/package.json
RUN npm install

RUN mkdir -p /${BIN}/dist /${BIN}/src

ADD ${CONTAINER_PATH}/${BIN}/${BIN}.json /${BIN}/${BIN}.json

RUN mkdir /logs && touch /logs/tar-${COMTAINER}.log
ENV CMD_TAR="/${BIN}/node_modules/.bin/${BIN}"
ENV CMD_BUFFER="${CMD_TAR}"