#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)

usage()
{
    echo "Usage: ${0} NAME"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/git_lab_tools.sh"

NAME="${1}"

if [ "${NAME}" = "" ]; then
    usage

    exit 1
fi

echo "${NAME}" | grep --quiet / && CONTAINS_SLASH=true || CONTAINS_SLASH=false
RESPONSE=$(${REQUEST} "${INTERFACE_LOCATOR}/projects?search=${NAME}")

if [ "${CONTAINS_SLASH}" = true ]; then
    IDENTIFIERS=$(echo "${RESPONSE}" | jsawk -n "if (this.path_with_namespace == '${NAME}') out(this.id)")
else
    IDENTIFIERS=$(echo "${RESPONSE}" | jsawk -n "if (this.name == '${NAME}') out(this.id)")
fi

COUNT=$(echo -n "${IDENTIFIERS}" | grep -c '^') || COUNT=0

if [ "${COUNT}" = 0 ]; then
    echo "Project not found."

    exit 1
elif [ "${COUNT}" = 1 ]; then
    echo "${IDENTIFIERS}"
else
    echo "More than one project returned."

    exit 1
fi
