FROM node:latest

VOLUME ["/logs"]

ENV TYPE="buffer"

ADD "./utils/FileHandler.sh" /FileHandler.sh
RUN chmod +x /FileHandler.sh

ENTRYPOINT /FileHandler.sh