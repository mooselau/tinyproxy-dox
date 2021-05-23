FROM ubuntu:16.04

# env variables
ENV PACKAGE_URL="https://github.com/tinyproxy/tinyproxy/releases/download/1.11.0/tinyproxy-1.11.0.tar.gz"

WORKDIR /home

RUN   apt-get update -y && \
      # install dependencies
      apt-get install -y wget && \
      wget $PACKAGE_URL && \
      apt-get install -y automake build-essential asciidoc vim curl && \
      tar -zxf tinyproxy-1.11.0.tar.gz && \
      cd tinyproxy-1.11.0 && \
      # install tinyproxy
      ./autogen.sh && ./configure && make && make install && \
      # free up unused space
      cd .. && \
      rm -rf tinyproxy-1.11.0 tinyproxy-1.11.0.tar.gz && \
      apt-get remove -y automake asciidoc texlive && \
      apt -y autoremove && \
      apt-get -y clean