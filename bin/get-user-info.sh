#!/bin/sh -e

DIR=$(dirname "${0}")
SCRIPT_DIR=$(cd "${DIR}"; pwd)
. "${SCRIPT_DIR}/../lib/gitlab.sh"
KEY="${1}"
JSON=$(${REQUEST} "${API_URL}/user")

if [ "${KEY}" = "" ]; then
    echo "${JSON}" | python -m json.tool
else
    RESULT=$(echo "${JSON}" | jsawk -n "out(this.${KEY})" )
    echo "${RESULT}"
fi
