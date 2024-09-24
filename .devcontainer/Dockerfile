# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/devcontainers/python:3.12

# install custom root CA
COPY ca/* /usr/local/share/ca-certificates/
RUN update-ca-certificates

# copy required .env file
COPY .env .

# install linux packages
RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt update && apt-get --no-install-recommends install -y \
    gnupg g++ libgl1 libglib2.0-0 libpython3-dev libusb-1.0-0

# install PyTorch
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install torch torchvision --index-url https://download.pytorch.org/whl/cpu --disable-pip-version-check

# install YOLOv8
RUN --mount=type=cache,target=/root/.cache/pip \
    export $(grep -v '^#' .env | xargs -d '\n') \
    && pip install ultralytics==8.2.99 --disable-pip-version-check && rm .env