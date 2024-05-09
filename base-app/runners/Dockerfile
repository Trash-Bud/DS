FROM ubuntu:22.04

WORKDIR /runner

RUN apt-get -y update

RUN apt-get -y install curl

RUN apt-get -y install bash

RUN apt-get -y install wget

RUN wget http://ftp.us.debian.org/debian/pool/main/i/icu/libicu57_57.1-6+deb9u4_amd64.deb 

RUN dpkg -i libicu57_57.1-6+deb9u4_amd64.deb

# Create a folder
RUN mkdir actions-runner && cd actions-runner
# Download the latest runner package
RUN curl -o actions-runner-linux-x64-2.299.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.299.1/actions-runner-linux-x64-2.299.1.tar.gz
# Extract the installer
RUN tar xzf ./actions-runner-linux-x64-2.299.1.tar.gz

ENV RUNNER_ALLOW_RUNASROOT="1"

RUN ./config.sh --url https://github.com/FEUP-MEIC-DS-2022-1MEIC01/base-app --token AFSFAFANO7HJKCSUO5QF4BLDP6U46

CMD [ "./run.sh" ]
