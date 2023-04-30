#!/bin/sh

docker-compose \
  -f ./.docker/docker-compose.yaml \
  up

docker-compose \
  -f ./.docker/docker-compose.yaml \
  stop

docker-compose \
  -f ./.docker/docker-compose.yaml \
  rm -f
