FROM monera-base

ENV CONTAINER="uglify"
ENV PACKAGE="uglify-js"
ENV BIN="uglifyjs"

RUN npm install $PACKAGE

ENV CMD_TAR="./node_modules/.bin/${BIN} /src/index.js -o /dist/index.js"
ENV CMD_BUFFER="./node_modules/.bin/${BIN}"

RUN mkdir /logs && touch /logs/tar-${COMTAINER}.log