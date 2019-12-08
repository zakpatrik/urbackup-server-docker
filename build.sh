#!/bin/bash
set -x

# Accepted values for ARCH are amd64, armhf, arm64
ARCH=${1:-amd64}
VERSION=${2:-2.4.11}

docker build \
              --build-arg ARCH=${ARCH} \
              --build-arg VERSION=${VERSION} \
              --build-arg IMAGE_ARCH=$([ "${ARCH}" == "armhf" ] && echo "arm32v7/debian:stretch" || ([ "${ARCH}" == "arm64" ] && echo "arm64v8/debian:stretch") || echo "debian:stretch") \
              -t docker_urbackup:${ARCH}-${VERSION} \
              .
