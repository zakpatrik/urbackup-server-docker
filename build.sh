#!/bin/bash
set -x

ARCH=${1:-amd64}
VERSION=${2:-2.4.11}
TAG_VERSION=${3:-${VERSION}}

docker build \
              --build-arg ARCH=${ARCH} \
              --build-arg VERSION=${VERSION} \
              --build-arg IMAGE_ARCH=$([ "${BUILD_ARCH}" == "armhf" ] && echo "arm32v7/debian:stretch" || ([ "${BUILD_ARCH}" == "aarch64" ] && echo "arm64v8/debian:stretch") || echo "debian:stretch") \
              -t docker_urbackup:${ARCH}-${TAG_VERSION} \
              .
