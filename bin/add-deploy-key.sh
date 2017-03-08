#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)

usage()
{
    echo "Usage: ${0} REPOSITORY TITLE KEY"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gitlab.sh"

REPOSITORY="${1}"
TITLE="${2}"
KEY="${3}"

if [ "${REPOSITORY}" = "" ] || [ "${TITLE}" = "" ] || [ "${KEY}" = "" ]; then
    usage

    exit 1
fi

IDENTIFIER=$("${SCRIPT_DIRECTORY}/get-repository-identifier.sh" --config "${CONFIG}" "${REPOSITORY}" | awk '{ print $1 }')
BODY="{ \"title\": \"${TITLE}\", \"key\": \"${KEY}\" }"
${REQUEST} "${API_URL}/projects/${IDENTIFIER}/keys" -d "${BODY}" | python -m json.tool
