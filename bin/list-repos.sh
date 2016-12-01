#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)

usage()
{
    echo "Usage: ${0} [--with-vendor]"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gitlab.sh"
JSON=$(${REQUEST} "${API_URL}/projects/owned")

if [ "${1}" = --with-vendor ]; then
    NAMES=$(echo "${JSON}" | jsawk -n "out(this.path_with_namespace)")
else
    NAMES=$(echo "${JSON}" | jsawk -n "out(this.name)")
fi

echo "${NAMES}"
