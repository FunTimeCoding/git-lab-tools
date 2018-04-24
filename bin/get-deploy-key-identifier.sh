#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)

usage()
{
    echo "Usage: ${0} REPOSITORY TITLE"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/git_lab_tools.sh"

TITLE="${1}"
REPOSITORY="${1}"

if [ "${TITLE}" = "" ] || [ "${REPOSITORY}" = "" ]; then
    usage

    exit 1
fi

PROJECT_IDENTIFIER=$("${SCRIPT_DIRECTORY}/get-project-identifier.sh" --configuration "${CONFIGURATION}" "${REPOSITORY}")
# TODO: This only shows enabled SSH keys of a project. All SSH keys can only be listed with an admin API key.
${REQUEST} "${INTERFACE_LOCATOR}/projects/${PROJECT_IDENTIFIER}/deploy_keys" | jsawk -n "out(this.id)"
