FROM monera-base

ENV CONTAINER="metalsmith"
ENV PACKAGE=$CONTAINER
ENV BIN=$PACKAGE

WORKDIR /${BIN}

ADD ${BIN}/package.json /${BIN}/package.json
RUN npm install

RUN mkdir -p /${BIN}/dist /${BIN}/src

ADD ${BIN}/${BIN}.json /${BIN}/${BIN}.json

RUN mkdir /logs && touch /logs/tar-metalsmith.log
ENV CMD_TAR="/${BIN}/node_modules/.bin/${BIN}"
ENV CMD_BUFFER="${CMD_TAR}"