FROM monera-base

ENV CONTAINER="metalsmith"
ENV PACKAGE=$CONTAINER
ENV BIN=$PACKAGE

WORKDIR /${BIN}

ADD ${CONTAINER_PATH}/${BIN}/package.json /package.json
RUN npm install

RUN mkdir -p /dist /src

ADD ${CONTAINER_PATH}/${BIN}/${BIN}.json /${BIN}.json

RUN mkdir /logs && touch /logs/tar-${COMTAINER}.log
ENV CMD_TAR="/node_modules/.bin/${BIN}"
ENV CMD_BUFFER="${CMD_TAR}"