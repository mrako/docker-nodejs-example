# NodeJS for Docker

This is an example project for running [nodejs](https://nodejs.org/) in a [docker](https://www.docker.com/) container.

## Building

    docker build .

## Running

    docker run -P -d <image id>

## Running interactively

    docker run -ti <image id> bash

## Connecting to docker image

    docker ps
    docker port <container id>
    docker-machine ip default

    curl -i <machine ip>:<docker port>