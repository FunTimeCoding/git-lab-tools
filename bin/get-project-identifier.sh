#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)

usage()
{
    echo "Usage: ${0} NAME [NAMESPACE]"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/git_lab_tools.sh"

NAME="${1}"
NAMESPACE="${2}"

if [ "${NAME}" = "" ]; then
    usage

    exit 1
fi

RESPONSE=$(${REQUEST} "${INTERFACE_LOCATOR}/projects?search=${NAME}")

if [ "${NAMESPACE}" = "" ]; then
    IDENTIFIERS=$(echo "${RESPONSE}" | jsawk -n "if (this.name == '${NAME}') out(this.id)")
else
    IDENTIFIERS=$(echo "${RESPONSE}" | jsawk -n "if (this.name == '${NAME}' && this.path_with_namespace == '${NAMESPACE}') out(this.id)")
fi

COUNT=$(echo "${IDENTIFIERS}" | wc -l | xargs)

if [ "${COUNT}" = "" ]; then
    echo "Empty search result."

    exit 1
elif [ "${COUNT}" = 1 ]; then
    echo "${IDENTIFIERS}"
else
    echo "More than one project returned."

    exit 1
fi
