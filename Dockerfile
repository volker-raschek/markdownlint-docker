FROM docker.io/library/node:22.4.1-alpine3.19 AS build

ARG MARKDOWNLINT_VERSION=master

RUN set -ex && \
    apk update && \
    apk upgrade && \
    apk add --no-cache git

RUN git clone --branch ${MARKDOWNLINT_VERSION} https://github.com/igorshubovych/markdownlint-cli /markdownlint && \
    cd /markdownlint && \
    npm install --production && \
    npm install --global

WORKDIR /work

RUN ln -fs /work /workspace

ENTRYPOINT [ "/usr/local/bin/markdownlint" ]
