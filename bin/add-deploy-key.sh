#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(
    cd "${DIRECTORY}"
    pwd
)

usage() {
    echo "Usage: ${0} PROJECT TITLE KEY"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/git_lab_tools.sh"

PROJECT="${1}"
TITLE="${2}"
KEY="${3}"

if [ "${PROJECT}" = '' ] || [ "${TITLE}" = '' ] || [ "${KEY}" = '' ]; then
    usage

    exit 1
fi

PROJECT_IDENTIFIER=$("${SCRIPT_DIRECTORY}/get-project-identifier.sh" --configuration "${CONFIGURATION}" "${PROJECT}")
BODY="{ \"title\": \"${TITLE}\", \"key\": \"${KEY}\" }"
${REQUEST} "${INTERFACE_LOCATOR}/projects/${PROJECT_IDENTIFIER}/keys" -d "${BODY}" | python -m json.tool
