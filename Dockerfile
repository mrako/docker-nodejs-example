FROM        ubuntu:14.04

# PROJECT VARIABLES
MAINTAINER  Marko Klemetti "marko.klemetti@gmail.com"
ENV         PROJECT_REPOSITORY "https://github.com/mrako/nodejs-example.git"

# ADD NODESOURCE AND INSTALL NODEJS
RUN         sudo apt-get update
RUN         sudo apt-get install -y curl git-core

RUN         curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
RUN         sudo apt-get install -y nodejs

# REMOVE HOST KEY CHECKING
RUN         mkdir /root/.ssh/
RUN         echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

# CLONE REPOSITORY
RUN         git clone $PROJECT_REPOSITORY /src

# INSTALL PACKAGES
RUN         cp /src/package.json /tmp/package.json
RUN         cd /tmp && npm install
RUN         mkdir -p /src && cp -a /tmp/node_modules /src/

# ADD PROJECT FILES
WORKDIR     /src

# TEST PROJECT
RUN         npm test

# CONFIGURE IMAGE
EXPOSE      8080
CMD         ["npm", "start"]
