#!/bin/sh

docker-compose \
  -f ./.docker/docker-compose.yaml \
  run hx \
  ash

docker-compose \
  -f ./.docker/docker-compose.yaml \
  stop

docker-compose \
  -f ./.docker/docker-compose.yaml \
  rm -f
