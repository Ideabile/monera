FROM ideabile/monera-base:latest

ENV CONTAINER="browserify"
ENV PACKAGE="browserify"
ENV BIN=$PACKAGE
ARG CONTAINERS_PATH="./containers"

WORKDIR /
RUN npm install -g $PACKAGE

ENV CMD_TAR="${BIN} /monera/src/index.js -o /monera/dist/index.js"
ENV CMD_BUFFER="${BIN} -"
RUN touch /logs/tar-${COMTAINER}.log

WORKDIR /monera
