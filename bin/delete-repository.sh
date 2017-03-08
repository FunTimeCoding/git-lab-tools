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

IDENTIFIER=$("${SCRIPT_DIRECTORY}/get-repository-identifier.sh" --config "${CONFIG}" "${NAME}" | awk '{ print $1 }')
${REQUEST} -X DELETE "${API_URL}/projects/${IDENTIFIER}" | python -m json.tool
