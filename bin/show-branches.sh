#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(
    cd "${DIRECTORY}"
    pwd
)

usage() {
    echo "Usage: ${0} PROJECT"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/git_lab_tools.sh"

PROJECT="${1}"

if [ "${PROJECT}" = '' ]; then
    usage

    exit 1
fi

PROJECT_IDENTIFIER=$("${SCRIPT_DIRECTORY}/get-project-identifier.sh" --configuration "${CONFIGURATION}" "${PROJECT}")
echo "Name Merged"
${REQUEST} "${INTERFACE_LOCATOR}/projects/${PROJECT_IDENTIFIER}/repository/branches" | jq --raw-output '.[] | select(.name != "master") | (.name + " " + (.merged | tostring))'
