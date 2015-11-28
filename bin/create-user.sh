#!/bin/sh -e

DIR=$(dirname "${0}")
SCRIPT_DIR=$(cd "${DIR}"; pwd)
. "${SCRIPT_DIR}/../lib/gitlab.sh"

usage ()
{
    echo "Usage: ${0} USERNAME PASSWORD \"FULL NAME\" EMAIL"
    exit 1
}

USERNAME="${1}"
PASSWORD="${2}"
NAME="${3}"
EMAIL="${4}"

[ "${USERNAME}" = "" ] && usage
[ "${PASSWORD}" = "" ] && usage
[ "${NAME}" = "" ] && usage
[ "${EMAIL}" = "" ] && usage

JSON=$(${REQUEST} "${API_URL}/users" -d "{ \"username\": \"${USERNAME}\", \"password\": \"${PASSWORD}\", \"name\": \"${NAME}\", \"email\": \"${EMAIL}\" }")
echo "${JSON}" | python -m json.tool
