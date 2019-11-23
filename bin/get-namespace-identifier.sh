#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)

usage()
{
    echo "Usage: ${0} NAME"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/git_lab_tools.sh"

NAME="${1}"

if [ "${NAME}" = '' ]; then
    usage

    exit 1
fi

${REQUEST} "${INTERFACE_LOCATOR}/namespaces?search=${NAME}" | jq --raw-output '(.[].id)'
