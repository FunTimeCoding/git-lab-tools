#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)

usage()
{
    echo "Usage: ${0} [--visibility public|internal|private] NAME"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/git_lab_tools.sh"

while true; do
    case ${1} in
        --visibility)
            VISIBILITY=${2-}
            shift 2
            ;;
        *)
            break
            ;;
    esac
done

NAME="${1}"

if [ "${NAME}" = '' ]; then
    usage

    exit 1
fi

if [ "${VISIBILITY}" = public ]; then
    VISIBILITY_LEVEL=20
elif [ "${VISIBILITY}" = internal ]; then
    VISIBILITY_LEVEL=10
elif [ "${VISIBILITY}" = private ]; then
    VISIBILITY_LEVEL=0
else
    VISIBILITY_LEVEL=0
fi

if [ "${NAMESPACE}" = '' ]; then
    BODY="{ \"name\": \"${NAME}\", \"visibility_level\": \"${VISIBILITY_LEVEL}\" }"
else
    IDENTIFIER=$("${SCRIPT_DIRECTORY}/get-namespace-identifier.sh" --configuration "${CONFIGURATION}" "${NAMESPACE}" | awk '{ print $1 }')
    BODY="{ \"name\": \"${NAME}\", \"visibility_level\": \"${VISIBILITY_LEVEL}\", \"namespace_id\": \"${IDENTIFIER}\" }"
fi

RESPONSE=$(${REQUEST} "${INTERFACE_LOCATOR}/projects" -d "${BODY}")
echo "${RESPONSE}" | python -m json.tool
