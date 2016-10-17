FROM monera-base

ENV CONTAINER="browserify"
ENV PACKAGE="browserify"
ENV BIN=$PACKAGE

RUN npm install $PACKAGE

RUN mkdir -p /dist /src

ENV CMD_TAR="./node_modules/.bin/${BIN} /src/index.js -o /dist/index.js"
ENV CMD_BUFFER="./node_modules/.bin/${BIN} -"

RUN mkdir /logs && touch /logs/tar-${COMTAINER}.log