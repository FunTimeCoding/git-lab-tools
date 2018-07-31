#!/bin/sh -e

docker images | grep --quiet funtimecoding/git-lab-tools && FOUND=true || FOUND=false

if [ "${FOUND}" = true ]; then
    docker rmi funtimecoding/git-lab-tools
fi

docker build --tag funtimecoding/git-lab-tools .
