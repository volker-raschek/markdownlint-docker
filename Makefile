# MARKDOWNLINT_VERSION
# Only required to install a specifiy version
MARKDOWNLINT_VERSION?=v0.38.0 # renovate: datasource=github-releases depName=igorshubovych/markdownlint-cli

# CONTAINER_RUNTIME
# The CONTAINER_RUNTIME variable will be used to specified the path to a
# container runtime. This is needed to start and run a container image.
CONTAINER_RUNTIME?=$(shell which podman)

# MARKDOWNLINT_IMAGE_REGISTRY_NAME
# Defines the name of the new container to be built using several variables.
MARKDOWNLINT_IMAGE_REGISTRY_NAME:=git.cryptic.systems
MARKDOWNLINT_IMAGE_REGISTRY_USER:=volker.raschek

MARKDOWNLINT_IMAGE_NAMESPACE?=${MARKDOWNLINT_IMAGE_REGISTRY_USER}
MARKDOWNLINT_IMAGE_NAME:=markdownlint
MARKDOWNLINT_IMAGE_VERSION?=latest
MARKDOWNLINT_IMAGE_FULLY_QUALIFIED=${MARKDOWNLINT_IMAGE_REGISTRY_NAME}/${MARKDOWNLINT_IMAGE_NAMESPACE}/${MARKDOWNLINT_IMAGE_NAME}:${MARKDOWNLINT_IMAGE_VERSION}
MARKDOWNLINT_IMAGE_UNQUALIFIED=${MARKDOWNLINT_IMAGE_NAMESPACE}/${MARKDOWNLINT_IMAGE_NAME}:${MARKDOWNLINT_IMAGE_VERSION}

# BUILD CONTAINER IMAGE
# ==============================================================================
PHONY:=container-image/build
container-image/build:
	${CONTAINER_RUNTIME} build \
		--build-arg MARKDOWNLINT_VERSION=${MARKDOWNLINT_VERSION} \
		--file Dockerfile \
		--no-cache \
		--pull \
		--tag ${MARKDOWNLINT_IMAGE_FULLY_QUALIFIED} \
		--tag ${MARKDOWNLINT_IMAGE_UNQUALIFIED} \
		.

# DELETE CONTAINER IMAGE
# ==============================================================================
PHONY:=container-image/delete
container-image/delete:
	- ${CONTAINER_RUNTIME} image rm ${MARKDOWNLINT_IMAGE_FULLY_QUALIFIED} ${MARKDOWNLINT_IMAGE_UNQUALIFIED}
	- ${CONTAINER_RUNTIME} image rm ${BASE_IMAGE_FULL}

# PUSH CONTAINER IMAGE
# ==============================================================================
PHONY+=container-image/push
container-image/push:
	echo ${MARKDOWNLINT_IMAGE_REGISTRY_PASSWORD} | ${CONTAINER_RUNTIME} login ${MARKDOWNLINT_IMAGE_REGISTRY_NAME} --username ${MARKDOWNLINT_IMAGE_REGISTRY_USER} --password-stdin
	${CONTAINER_RUNTIME} push ${MARKDOWNLINT_IMAGE_FULLY_QUALIFIED}

# PHONY
# ==============================================================================
# Declare the contents of the PHONY variable as phony.  We keep that information
# in a variable so we can use it in if_changed.
.PHONY: ${PHONY}
