FROM ideabile/monera-base:latest

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
  && pip install virtualenv \
  && rm -rf /var/cache/apk/*

ENV CONTAINER="sass"
ENV PACKAGE="node-sass"
ENV BIN=$PACKAGE
ARG CONTAINERS_PATH="."

RUN npm install mkdirp
RUN npm install $PACKAGE

RUN touch /logs/tar-sass.log
ENV CMD_TAR="/monera/node_modules/.bin/${BIN} --include-path /node_modules/ /monera/src/index.scss -o /monera/dist/" 
ENV CMD_BUFFER="/monera/node_modules/.bin/${BIN}"
