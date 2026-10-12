ARG BUILD_FROM=python:3.11-slim-bookworm
FROM $BUILD_FROM

ENV LANG C.UTF-8

# Install system dependencies for bluepy and jq for parsing options
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        jq \
        libglib2.0-dev \
        build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy the avionmqtt package
COPY avionmqtt /app/avionmqtt
WORKDIR /app/avionmqtt

# Install python dependencies and the avionmqtt package
RUN pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir bluepy paho-mqtt \
    && pip3 install --no-cache-dir .

WORKDIR /
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]