#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)

usage()
{
    echo "Usage: ${0} REPOSITORY_NAME TITLE DEPLOY_KEY"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gitlab.sh"

REPOSITORY_NAME="${1}"
TITLE="${2}"
DEPLOY_KEY="${3}"

if [ "${REPOSITORY_NAME}" = "" ] || [ "${TITLE}" = "" ] || [ "${DEPLOY_KEY}" = "" ]; then
    usage

    exit 1
fi

REPOSITORY_IDENTIFIER=$("${SCRIPT_DIRECTORY}/get-repo-id.sh" -c "${CONFIG}" "${REPOSITORY_NAME}")
RESPONSE=$(${REQUEST} "${API_URL}/projects/${REPOSITORY_IDENTIFIER}/keys" -d "{ \"title\": \"${TITLE}\", \"key\": \"${DEPLOY_KEY}\" }")
echo "${RESPONSE}" | python -m json.tool
