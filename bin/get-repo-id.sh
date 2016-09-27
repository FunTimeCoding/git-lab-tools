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

RESPONSE=$(${REQUEST} "${API_URL}/projects/search/${REPOSITORY_NAME}")
COUNT=$(echo "${RESPONSE}" | jsawk -a "return this.length")

if [ "${COUNT}" = "1" ]; then
    RESULT_IDENTIFIER=$(echo "${RESPONSE}" | jsawk -n "out(this.id)" )
    echo "${RESULT_IDENTIFIER}"
else
    echo "Too many results: ${COUNT}"
fi
