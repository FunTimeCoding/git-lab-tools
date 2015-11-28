#!/bin/sh -e

DIR=$(dirname "${0}")
SCRIPT_DIR=$(cd "${DIR}"; pwd)
. "${SCRIPT_DIR}/../lib/gitlab.sh"

usage ()
{
    echo "Usage: ${0} REPO_NAME"
    exit 1
}

REPO_NAME="${1}"

[ "${REPO_NAME}" = "" ] && usage

REPO_ID=$("${SCRIPT_DIR}/get-repo-id.sh" -c "${CONFIG}" "${REPO_NAME}")
JSON=$(${REQUEST} -X DELETE "${API_URL}/projects/${REPO_ID}")
echo "${JSON}" | python -m json.tool
