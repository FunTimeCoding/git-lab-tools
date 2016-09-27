#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)
# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gitlab.sh"
JSON=$(${REQUEST} "${API_URL}/projects/owned")
NAMES=$(echo "${JSON}" | jsawk -n "out(this.name)")
echo "${NAMES}"
