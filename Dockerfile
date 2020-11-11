FROM fedora:32  AS builder

# docker-compose requires pyinstaller 3.6 (check github.com/docker/compose/requirements-build.txt)
ARG PYINSTALLER_VER=3.6

ENV LANG C.UTF-8

RUN dnf update -y
RUN dnf install clang zlib-devel git python3-pip -y
ENV CC=clang
ARG VERSION
RUN set -xe && \
    mkdir -p /build/pyinstallerbootloader && \
    # Compile the pyinstaller "bootloader"
    # https://pyinstaller.readthedocs.io/en/stable/bootloader-building.html
    cd /build/pyinstallerbootloader && \
    curl -sSL https://github.com/pyinstaller/pyinstaller/releases/download/v$PYINSTALLER_VER/PyInstaller-$PYINSTALLER_VER.tar.gz | tar xz --strip 1 && \
    cd bootloader && python3 ./waf all && \
    # Clone docker-compose
    mkdir -p /build/dockercompose && \
    cd /build/dockercompose && \
    git clone https://github.com/docker/compose.git . && \
    git checkout $VERSION && \
    # ./script/build/write-git-sha && \
    git rev-parse --short HEAD > compose/GITSHA && \
    # Run the build steps (taken from github.com/docker/compose/script/build/linux-entrypoint)
    mkdir ./dist && \
    pip install -q -r requirements.txt -r requirements-build.txt && \
    pyinstaller docker-compose.spec && \
    mv dist/docker-compose /usr/bin/docker-compose

FROM alpine:3.12
COPY --from=builder /usr/bin/docker-compose /usr/bin/docker-compose
# Copy out the generated binary
VOLUME /dist
CMD cp -f /usr/bin/docker-compose /dist
