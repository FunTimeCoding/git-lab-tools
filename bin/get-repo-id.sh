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

JSON=$(${REQUEST} "${API_URL}/projects/search/${REPO_NAME}")
COUNT=$(echo "${JSON}" | jsawk -a "return this.length")

if [ "${COUNT}" = "1" ]; then
    RESULT_ID=$(echo "${JSON}" | jsawk -n "out(this.id)" )
    echo "${RESULT_ID}"
else
    echo "Too many results: ${COUNT}"
fi
