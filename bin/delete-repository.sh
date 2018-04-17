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

PROJECT_IDENTIFIER=$("${SCRIPT_DIRECTORY}/get-project-identifier.sh" --config "${CONFIG}" "${NAME}")
${REQUEST} -X DELETE "${API_URL}/projects/${PROJECT_IDENTIFIER}" | python -m json.tool
