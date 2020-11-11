# docker-compose binary file

Fork from <https://github.com/vgist/dockerfiles>

This repository contains helpers to build a docker-compose binary file for Fedora distribution, including FCOS. Because, docker-compose [releases](https://github.com/docker/compose/releases) require additional libxcrypt-compat which may  not be installed (and not available in FCOS unless installed with rpm-ostree).

## Get binary docker-compose on your current platform

Clone the repo and run:
```bash
docker build . -t docker-compose-fedora && docker run --rm -v /usr/local/bin:/dist docker-compose-fedora && docker rmi docker-compose-fedora
```

To install a specific version, add `--build-arg VERSION=<docker_compose_version>`  e.g. `--build-arg VERSION=1.27.4` to the `docker build` command.
You may need `sudo` to run. It will build the latest image, and run it to generate the binary docker-compose in `/usr/local/bin`.

## One-line installation (probably won't work if you're enforcing selinux)

Latest master:
```bash
curl -sS https://raw.githubusercontent.com/ppettina/docker-compose-fedora/master/install_docker_compose.sh | bash
```

Specific version:
```bash
curl -sS https://raw.githubusercontent.com/ppettina/docker-compose-fedora/master/install_docker_compose.sh | VERSION=1.27.4 bash
```
