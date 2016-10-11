FROM node:latest

VOLUME ["/logs", "]

ENV TYPE="buffer"
ENV CONTAINER_PATH="./containers"
ENV PROJECT_PATH="."

ADD "${CONTAINER_PATH}/_utils/FileHandler.sh" /FileHandler.sh
RUN chmod +x /FileHandler.sh

ADD "${PROJECT_PATH}/package.json" /package.json
RUN npm install

ENTRYPOINT /FileHandler.sh