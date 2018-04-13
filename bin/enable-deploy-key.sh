#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)

usage()
{
    echo "Usage: ${0} REPOSITORY TITLE"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gitlab.sh"

REPOSITORY="${1}"
TITLE="${2}"

if [ "${REPOSITORY}" = "" ] || [ "${TITLE}" = "" ]; then
    usage

    exit 1
fi

PROJECT_IDENTIFIER=$("${SCRIPT_DIRECTORY}/get-repository-identifier.sh" --config "${CONFIG}" "${REPOSITORY}" | awk '{ print $1 }')
# TODO: Resolve the key title to the identifier correctly.
#KEY_IDENTIFIER=$("${SCRIPT_DIRECTORY}/get-deploy-key-identifier.sh" --config "${CONFIG}" "${REPOSITORY}" "${TITLE}")
KEY_IDENTIFIER="${TITLE}"
${REQUEST} --request POST "${API_URL}/projects/${PROJECT_IDENTIFIER}/deploy_keys/${KEY_IDENTIFIER}/enable" | python -m json.tool
