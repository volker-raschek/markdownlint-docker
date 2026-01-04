# markdownlint-docker

[![Docker Pulls](https://img.shields.io/docker/pulls/volkerraschek/markdownlint)](https://hub.docker.com/r/volkerraschek/markdownlint)

This project contains all sources to build the container image `git.cryptic.systems/volker.raschek/markdownlint`. The
primary goal of this project is to package the binary `markdownlint-ci` as container image. The source code of the
binary can be found in the upstream project of [igorshubovych](https://github.com/igorshubovych/markdownlint-cli).

The workflow or how `markdownlint-ci` can be used is pretty good
[documented](https://github.com/igorshubovych/markdownlint-cli#usage).

```bash
IMAGE_VERSION=0.45.0
docker run \
  --rm \
  --volume "$(pwd):$(pwd)" \
  --workdir "$(pwd)" \
    "git.cryptic.systems/volker.raschek/markdownlint:${IMAGE_VERSION}" \
      --help
```
