#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(
    cd "${DIRECTORY}"
    pwd
)

usage() {
    echo "Usage: ${0} PROJECT SOURCE_BRANCH TARGET_BRANCH TITLE"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/git_lab_tools.sh"

PROJECT="${1}"
SOURCE_BRANCH="${2}"
TARGET_BRANCH="${3}"
TITLE="${4}"

if [ "${PROJECT}" = '' ] || [ "${SOURCE_BRANCH}" = '' ] || [ "${TARGET_BRANCH}" = '' ] || [ "${TITLE}" = '' ]; then
    usage

    exit 1
fi

PROJECT_IDENTIFIER=$("${SCRIPT_DIRECTORY}/get-project-identifier.sh" --configuration "${CONFIGURATION}" "${PROJECT}")
BODY="{ \"id\": \"${PROJECT_IDENTIFIER}\", \"source_branch\": \"${SOURCE_BRANCH}\", \"target_branch\": \"${TARGET_BRANCH}\", \"title\": \"${TITLE}\" }"
${REQUEST} "${INTERFACE_LOCATOR}/projects/${PROJECT_IDENTIFIER}/merge_requests" -d "${BODY}" | python -m json.tool
