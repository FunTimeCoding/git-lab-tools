#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)

usage()
{
    echo "Usage: ${0} [KEY]"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gitlab.sh"

KEY="${1}"
RESPONSE=$(${REQUEST} "${API_URL}/user")

if [ "${KEY}" = "" ]; then
    echo "${RESPONSE}" | python -m json.tool
else
    RESULT=$(echo "${RESPONSE}" | jsawk -n "out(this.${KEY})" )
    echo "${RESULT}"
fi
