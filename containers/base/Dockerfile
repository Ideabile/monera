FROM mhart/alpine-node:latest

VOLUME ["/logs"]

ENV TYPE="tar"
ARG CONTAINERS_PATH="."

ADD ${CONTAINERS_PATH}/base/EntryPoint.sh /EntryPoint.sh
RUN chmod +x /EntryPoint.sh
RUN mkdir -p /monera/src /monera/dist

WORKDIR /monera

ENTRYPOINT /EntryPoint.sh