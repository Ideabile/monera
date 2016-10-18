FROM node:latest


ENV PROJECT_PATH="."
WORKDIR /monera

ADD "${PROJECT_PATH}/package.json" /monera/package.json

RUN npm install

VOLUME ["/monera/node_modules"]