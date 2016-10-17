FROM node

VOLUME ["/logs", "]

ENV TYPE="buffer"
ENV CONTAINER_PATH="./containers"
ENV PROJECT_PATH="."

ADD "${CONTAINER_PATH}/_utils/FileHandler.sh" /FileHandler.sh
RUN chmod +x /FileHandler.sh

ENTRYPOINT /FileHandler.sh