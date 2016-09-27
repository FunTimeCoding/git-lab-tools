#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)

usage()
{
    echo "Usage: ${0} REPOSITORY_NAME"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gitlab.sh"

REPOSITORY_NAME="${1}"

if [ "${REPOSITORY_NAME}" = "" ]; then
    usage
    exit 1
fi

REPO_IDENTIFIER=$("${SCRIPT_DIRECTORY}/get-repo-id.sh" -c "${CONFIG}" "${REPOSITORY_NAME}")
RESPONSE=$(${REQUEST} -X DELETE "${API_URL}/projects/${REPO_IDENTIFIER}")
echo "${RESPONSE}" | python -m json.tool
