#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)

usage()
{
    echo "Usage: ${0} REPO_NAME"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gitlab.sh"

REPO_NAME="${1}"

if [ "${REPO_NAME}" = "" ]; then
    usage

    exit 1
fi

RESPONSE=$(${REQUEST} "${API_URL}/projects" -d "{ \"name\": \"${REPO_NAME}\", \"public\": true }")
echo "${RESPONSE}" | python -m json.tool
