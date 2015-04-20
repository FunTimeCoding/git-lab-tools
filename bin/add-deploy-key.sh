#!/bin/sh -e

SCRIPT_DIR=$(cd "$(dirname "${0}")"; pwd)
. "${SCRIPT_DIR}/../lib/gitlab.sh"

usage ()
{
    echo "Usage: ${0} REPO_NAME TITLE DEPLOY_KEY"
    exit 1
}

REPO_NAME="${1}"
TITLE="${2}"
DEPLOY_KEY="${3}"

[ "${REPO_NAME}" = "" ] && usage
[ "${TITLE}" = "" ] && usage
[ "${DEPLOY_KEY}" = "" ] && usage

REPO_ID=$("${SCRIPT_DIR}/get-repo-id.sh" -c "${CONFIG}" "${REPO_NAME}")
JSON=$(${REQUEST} "${API_URL}/projects/${REPO_ID}/keys" -d "{ \"title\": \"${TITLE}\", \"key\": \"${DEPLOY_KEY}\" }")
echo "${JSON}" | python -m json.tool
