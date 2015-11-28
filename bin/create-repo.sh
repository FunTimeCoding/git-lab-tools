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

JSON=$(${REQUEST} "${API_URL}/projects" -d "{ \"name\": \"${REPO_NAME}\", \"public\": true }")
echo "${JSON}" | python -m json.tool
