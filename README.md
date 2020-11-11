# docker-compose binary file

Fork from <https://github.com/vgist/dockerfiles>

This repository contains helpers to build a docker-compose binary file for Fedora distribution, including FCOS. Because, docker-compose [releases](https://github.com/docker/compose/releases) require additional libxcrypt-compat which may  not be installed (and not available in FCOS unless installed with rpm-ostree).

## Get binary docker-compose on your current platform

```bash
docker build . -t docker-compose-fedora && docker run --rm -v /usr/local/bin:/dist docker-compose-fedora && docker rmi docker-compose-fedora
```

You may need `sudo` to run. It will build the latest image, and run it to generate the binary docker-compose in `/usr/local/bin`.
