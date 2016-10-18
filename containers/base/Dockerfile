FROM mhart/alpine-node:latest

VOLUME ["/logs"]

ENV TYPE="buffer"
ENV CONTAINER_PATH="./containers"

ADD ${CONTAINER_PATH}/base/EntryPoint.sh /EntryPoint.sh
RUN chmod +x /EntryPoint.sh
RUN mkdir -p /monera/src /monera/dist

WORKDIR /monera

ENTRYPOINT /EntryPoint.sh