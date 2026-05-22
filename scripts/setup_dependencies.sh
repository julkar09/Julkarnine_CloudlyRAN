#!/bin/bash

echo "Updating system packages..."

apt-get update -y

echo "Installing basic dependencies..."

apt-get install -y \
    build-essential \
    curl \
    wget \
    git \
    vim \
    net-tools \
    unzip

echo "Installation completed successfully."