#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)

usage()
{
    echo "Usage: ${0} [KEY]"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/git_lab_tools.sh"

KEY="${1}"
RESPONSE=$(${REQUEST} "${INTERFACE_LOCATOR}/user")

if [ "${KEY}" = "" ]; then
    echo "${RESPONSE}" | python -m json.tool
else
    RESULT=$(echo "${RESPONSE}" | jsawk -n "out(this.${KEY})" )
    echo "${RESULT}"
fi
