FROM monera-base

ENV CONTAINER="metalsmith"
ENV PACKAGE=$CONTAINER
ENV BIN=$PACKAGE

ARG CONTAINERS_PATH="."


ADD ${CONTAINERS_PATH}/${BIN}/package.json /monera/package.json
RUN npm install

ADD ${CONTAINERS_PATH}/${BIN}/${BIN}.json /monera/src/${BIN}.json

RUN touch /logs/tar-${COMTAINER}.log
ENV CMD_TAR="/monera/node_modules/.bin/${BIN}"
ENV CMD_BUFFER="${CMD_TAR}"