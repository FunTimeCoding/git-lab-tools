#!/bin/sh -e

script/docker/remove.sh

# Remove image.
docker rmi funtimecoding/git-lab-tools

# Remove dangling image identifiers, and more.
docker system prune
