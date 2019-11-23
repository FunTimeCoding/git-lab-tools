#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)
# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/git_lab_tools.sh"
${REQUEST} "${INTERFACE_LOCATOR}/projects/all" | jq --raw-output '.[].name'
