#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(
    cd "${DIRECTORY}"
    pwd
)

usage() {
    echo "Usage: ${0} GROUP"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/git_lab_tools.sh"

GROUP="${1}"

if [ "${GROUP}" = '' ]; then
    usage

    exit 1
fi

GROUP_IDENTIFIER=$("${SCRIPT_DIRECTORY}/get-namespace-identifier.sh" --configuration "${CONFIGURATION}" "${GROUP}")
${REQUEST} "${INTERFACE_LOCATOR}/groups/${GROUP_IDENTIFIER}/registry/repositories?tags=true" | jq --raw-output
