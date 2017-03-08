#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)

usage()
{
    echo "Usage: ${0} NAME"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gitlab.sh"

NAME="${1}"

if [ "${NAME}" = "" ]; then
    usage

    exit 1
fi

${REQUEST} "${API_URL}/projects?search=${NAME}" | jsawk -n "out(this.id + ' ' + this.name)"
