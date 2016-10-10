FROM node:latest

VOLUME ["/logs", "]

ENV TYPE="buffer"

ADD "./utils/FileHandler.sh" /FileHandler.sh
RUN chmod +x /FileHandler.sh

ADD ./package.json /package.json
RUN npm install

ENTRYPOINT /FileHandler.sh