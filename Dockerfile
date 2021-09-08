FROM docker.io/library/alpine:3.12

ARG NODEJS_VERSION=12.22.6-r0
ARG MARKDOWNLINT_VERSION

RUN set -ex && \
    apk add --no-cache nodejs=${NODEJS_VERSION} nodejs-npm=${NODEJS_VERSION}

RUN echo ${MARKDOWNLINT_VERSION}

RUN if [ ! -z "${MARKDOWNLINT_VERSION}" ]; then set -ex; npm install -g markdownlint-cli@${MARKDOWNLINT_VERSION}; fi
RUN if [ -z "${MARKDOWNLINT_VERSION}" ]; then set -ex; npm install -g markdownlint-cli; fi

RUN set -ex && \
    npm cache clean --force && \
    apk del nodejs-npm

WORKDIR /work
ENTRYPOINT ["/usr/bin/markdownlint"]
CMD ["."]
