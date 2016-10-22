FROM node:latest


ENV PROJECT_PATH="."
WORKDIR /monera

ADD "${PROJECT_PATH}/package.json" /monera/package.json

RUN npm install
RUN mv /monera/node_modules /node_modules

VOLUME ["/node_modules"]