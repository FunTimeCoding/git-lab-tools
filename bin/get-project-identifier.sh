#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(
    cd "${DIRECTORY}"
    pwd
)

usage() {
    echo "Usage: ${0} NAME"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/git_lab_tools.sh"

DEBUG=true
NAME="${1}"

if [ "${NAME}" = '' ]; then
    usage

    exit 1
fi

echo "${NAME}" | grep --quiet / && CONTAINS_SLASH=true || CONTAINS_SLASH=false

if [ "${CONTAINS_SLASH}" = true ]; then
    NAME_WITHOUT_NAMESPACE="${NAME#*/}"
    RESPONSE=$(${REQUEST} "${INTERFACE_LOCATOR}/projects?search=${NAME_WITHOUT_NAMESPACE}&simple=true")
    IDENTIFIERS=$(echo "${RESPONSE}" | tr -d '\r\n' | jq --raw-output ".[] | select(.path_with_namespace == \"${NAME}\") | (.id)")
else
    RESPONSE=$(${REQUEST} "${INTERFACE_LOCATOR}/projects?search=${NAME}&simple=true")
    IDENTIFIERS=$(echo "${RESPONSE}" | tr -d '\r\n' | jq --raw-output ".[] | select(.name == \"${NAME}\") | (.id)")
fi

if [ "${DEBUG}" = true ]; then
    mkdir -p "${SCRIPT_DIRECTORY}/../tmp"
    echo "${RESPONSE}" >"${SCRIPT_DIRECTORY}/../tmp/get-project-identifier.txt"
fi

COUNT=$(printf "%s" "${IDENTIFIERS}" | grep -c '^') || COUNT=0

if [ "${COUNT}" = 0 ]; then
    echo "Project not found."

    exit 1
elif [ "${COUNT}" = 1 ]; then
    echo "${IDENTIFIERS}"
else
    echo "More than one project returned."

    exit 1
fi
