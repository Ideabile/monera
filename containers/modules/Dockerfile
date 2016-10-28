FROM node:latest


ENV PROJECT_PATH="."
WORKDIR /monera
ARG CONTAINERS_PATH="."

ADD "${BASEPATH_PATH}/package.json" /monera/package.json

RUN npm install
RUN mv /monera/node_modules /node_modules

VOLUME "/node_modules"