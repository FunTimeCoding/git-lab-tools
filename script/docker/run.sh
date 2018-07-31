#!/bin/sh -e

# Development mode mounts the project root so it can be edited and re-ran without rebuilding the image and recreating the container.

if [ "${1}" = --development ]; then
    DEVELOPMENT=true
else
    DEVELOPMENT=false
fi

docker ps --all | grep --quiet git-lab-tools && FOUND=true || FOUND=false

if [ "${FOUND}" = false ]; then
    if [ "${DEVELOPMENT}" = true ]; then
        docker create --name git-lab-tools --volume $(pwd):/git-lab-tools funtimecoding/git-lab-tools
    else
        docker create --name git-lab-tools funtimecoding/git-lab-tools
    fi

    # TODO: Specifying the entry point overrides CMD in Dockerfile. Is this useful, or should all sub commands go through one entry point script? I'm inclined to say one entry point script per project.
    #docker create --name git-lab-tools --volume $(pwd):/git-lab-tools --entrypoint /git-lab-tools/bin/other.sh funtimecoding/git-lab-tools
    #docker create --name git-lab-tools funtimecoding/git-lab-tools /git-lab-tools/bin/other.sh
    # TODO: Run tests this way?
    #docker create --name git-lab-tools funtimecoding/git-lab-tools /git-lab-tools/script/docker/test.sh
fi

docker start --attach git-lab-tools
