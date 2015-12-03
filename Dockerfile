FROM        ubuntu:14.04

MAINTAINER  Marko Klemetti "marko.klemetti@gmail.com"

# ADD NODESOURCE AND INSTALL NODE.JS
RUN         sudo apt-get update
RUN         sudo apt-get install -y curl

RUN         curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
RUN         sudo apt-get install -y nodejs

# INSTALL PACKAGES
ADD         package.json /tmp/package.json
RUN         cd /tmp && npm install
RUN         mkdir -p /src && cp -a /tmp/node_modules /src/

# ADD PROJECT FILES
WORKDIR     /src

ADD         package.json /src
ADD         app.js /src
ADD         test.js /src
ADD         server.js /src

# TEST THE PROJECT -- FAILURE WILL HALT IMAGE CREATION
RUN         npm test

# TESTS PASSED -- CONFIGURE IMAGE
EXPOSE      8080
CMD         ["npm", "start"]
