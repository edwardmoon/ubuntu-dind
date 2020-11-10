FROM ubuntu:20.04

MAINTAINER Billy Ray Teves <billyteves@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables \
    python3 \
    python3-pip \
    awscli && \
    rm -rf /var/lib/apt/lists/*
    
# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# Define additional metadata for our image.
VOLUME /var/lib/docker
CMD ["wrapdocker"]
