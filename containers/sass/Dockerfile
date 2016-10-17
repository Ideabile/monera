FROM monera-base

ENV CONTAINER="sass"
ENV PACKAGE="node-sass"
ENV BIN=$PACKAGE

RUN npm install $PACKAGE

RUN mkdir /logs && touch /logs/tar-sass.log
ENV CMD_TAR="./node_modules/.bin/${BIN} --include-path /node_modules/ /src/index.scss /dist/index.css" 
ENV CMD_BUFFER="./node_modules/.bin/${BIN}"