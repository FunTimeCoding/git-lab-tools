#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)

usage()
{
    echo "Usage: ${0} USERNAME PASSWORD \"FULL NAME\" EMAIL"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gitlab.sh"

USERNAME="${1}"
PASSWORD="${2}"
NAME="${3}"
EMAIL="${4}"

if [ "${USERNAME}" = "" ] || [ "${PASSWORD}" = "" ] || [ "${NAME}" = "" ] || [ "${EMAIL}" = "" ]; then
    usage

    exit 1
fi

RESPONSE=$(${REQUEST} "${API_URL}/users" -d "{ \"username\": \"${USERNAME}\", \"password\": \"${PASSWORD}\", \"name\": \"${NAME}\", \"email\": \"${EMAIL}\" }")
echo "${RESPONSE}" | python -m json.tool
