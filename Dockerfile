FROM docker.io/library/node:lts-alpine3.15 AS build

ARG MARKDOWNLINT_VERSION=master

RUN set -ex && \
    apk update && \
    apk upgrade && \
    apk add --no-cache git

RUN git clone --branch ${MARKDOWNLINT_VERSION} https://github.com/igorshubovych/markdownlint-cli /markdownlint && \
    cd /markdownlint && \
    npm install --production && \
    npm install --global

ENTRYPOINT [ "/usr/local/bin/markdownlint" ]
