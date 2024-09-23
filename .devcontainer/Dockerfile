FROM mcr.microsoft.com/devcontainers/python:3.12

# install custom root CA
COPY ca/* /usr/local/share/ca-certificates/
RUN update-ca-certificates

# copy required .env file
COPY .env .

# install PyTorch
RUN pip install torch torchvision --index-url https://download.pytorch.org/whl/cpu \
    --disable-pip-version-check --no-cache-dir

# install YOLOv8
RUN export $(grep -v '^#' .env | xargs -d '\n') && pip install ultralytics==8.2.99 \
    --disable-pip-version-check --no-cache-dir && rm .env