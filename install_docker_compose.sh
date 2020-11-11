#!/bin/bash
set -ex

TEMPDIR="$(mktemp -d)"
cleanup() {
    rm -rf "$TEMPDIR"
    docker rmi -f docker-compose-fedora || true
}
trap cleanup EXIT

cd "$TEMPDIR"
git clone https://github.com/ppettina/docker-compose-fedora.git
cd docker-compose-fedora
docker build . -t docker-compose-fedora
docker run --rm -v /usr/local/bin:/dist docker-compose-fedora
