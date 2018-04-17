#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)

usage()
{
    echo "Usage: ${0} PROJECT"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gitlab.sh"

PROJECT="${1}"

if [ "${PROJECT}" = "" ]; then
    usage

    exit 1
fi

PROJECT_IDENTIFIER=$("${SCRIPT_DIRECTORY}/get-project-identifier.sh" --config "${CONFIG}" "${PROJECT}")
echo "Name Merged"
${REQUEST} "${API_URL}/projects/${PROJECT_IDENTIFIER}/repository/branches" | jsawk -n "if (this.name != 'master') out(this.name + ' ' + this.merged)"
