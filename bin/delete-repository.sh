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

if [ "${NAME}" = "" ]; then
    usage

    exit 1
fi

PROJECT_IDENTIFIER=$("${SCRIPT_DIRECTORY}/get-project-identifier.sh" --configuration "${CONFIGURATION}" "${NAME}")
${REQUEST} -X DELETE "${INTERFACE_LOCATOR}/projects/${PROJECT_IDENTIFIER}" | python -m json.tool
