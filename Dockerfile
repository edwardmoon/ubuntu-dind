FROM ubuntu:20.04

MAINTAINER Billy Ray Teves <billyteves@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    lxc \
    iptables \
    python3 \
    python3-pip \
    software-properties-common \
    sudo \
    awscli && \
    rm -rf /var/lib/apt/lists/*
    
# Install Docker from Docker Inc. repositories.
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&\
   apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose && \
   rm -rf /var/lib/apt/lists/*

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# Define additional metadata for our image.
VOLUME /var/lib/docker
CMD ["wrapdocker"]
