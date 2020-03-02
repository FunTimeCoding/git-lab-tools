#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(
    cd "${DIRECTORY}"
    pwd
)

usage() {
    echo "Usage: ${0} REPOSITORY TITLE"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/git_lab_tools.sh"

REPOSITORY="${1}"
TITLE="${2}"

if [ "${REPOSITORY}" = '' ] || [ "${TITLE}" = '' ]; then
    usage

    exit 1
fi

PROJECT_IDENTIFIER=$("${SCRIPT_DIRECTORY}/get-project-identifier.sh" --configuration "${CONFIGURATION}" "${REPOSITORY}")
# TODO: Resolve the key title to the identifier correctly.
#KEY_IDENTIFIER=$("${SCRIPT_DIRECTORY}/get-deploy-key-identifier.sh" --configuration "${CONFIGURATION}" "${REPOSITORY}" "${TITLE}")
KEY_IDENTIFIER="${TITLE}"
${REQUEST} --request POST "${INTERFACE_LOCATOR}/projects/${PROJECT_IDENTIFIER}/deploy_keys/${KEY_IDENTIFIER}/enable" | python -m json.tool
