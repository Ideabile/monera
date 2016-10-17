FROM node:latest

VOLUME ["/src/node_modules"]

ENV PROJECT_PATH="."

ADD "${PROJECT_PATH}/package.json" /src/package.json
WORKDIR /src

RUN npm install