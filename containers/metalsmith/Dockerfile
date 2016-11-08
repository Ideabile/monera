FROM ideabile/monera-base:latest

ENV CONTAINER="metalsmith"
ARG CONTAINERS_PATH="./containers"


ADD ${CONTAINERS_PATH}/metalsmith/package.json /monera/package.json
RUN npm install

ADD ${CONTAINERS_PATH}/metalsmith/metalsmith.json /monera/src/metalsmith.json

RUN touch /logs/tar-${COMTAINER}.log
ENV CMD_TAR="/monera/node_modules/.bin/${BIN}"
ENV CMD_BUFFER="${CMD_TAR}"
