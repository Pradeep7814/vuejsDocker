# Use the official Ubuntu base image
#docker build -t my-ubuntu-docker .
#docker run -it my-ubuntu-docker
FROM ubuntu:20.04

# Set environment variables to avoid user interaction during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install necessary packages
RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add Docker's official GPG key
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Add Docker's official APT repository
RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update the package list again and install Docker
RUN apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# Start Docker service
RUN service docker start

# Set up a working directory
WORKDIR /workspace

# Copy your application files to the container
COPY . /workspace

# Run a command to verify Docker installation
RUN docker --version

# Set the entrypoint to bash
ENTRYPOINT ["/bin/bash"]
