# syntax=docker/dockerfile:1

## start dev
FROM mcr.microsoft.com/devcontainers/python:3.12 AS dev

# install custom root CA
COPY ca/* /usr/local/share/ca-certificates/
RUN update-ca-certificates

# install linux packages
RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt update && apt-get --no-install-recommends install -y \
    gnupg g++ libgl1 libglib2.0-0 libpython3-dev libusb-1.0-0

# install python packages
COPY .env requirements.txt ./
RUN --mount=type=cache,target=/root/.cache/pip \
    export $(grep -v '^#' .env | xargs -d '\n') \
    && pip install -r requirements.txt --disable-pip-version-check \
    && rm .env requirements.txt
## end dev

## start prod
FROM python:3.12.6-alpine AS prod
## end prod