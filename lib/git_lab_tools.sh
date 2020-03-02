#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(
    cd "${DIRECTORY}"
    pwd
)

CONFIGURATION=''

while true; do
    case ${1} in
    --configuration)
        CONFIGURATION=${2-}
        shift 2
        ;;
    --help)
        echo "Global usage: ${0} [--help][--configuration CONFIGURATION]"

        if command -v usage >/dev/null; then
            usage
        fi

        exit 0
        ;;
    *)
        break
        ;;
    esac
done

OPTIND=1

if [ "${CONFIGURATION}" = '' ]; then
    CONFIGURATION="${HOME}/.git-lab-tools.sh"
fi

if [ ! -f "${CONFIGURATION}" ]; then
    echo "Configuration missing: ${CONFIGURATION}"

    exit 1
fi

# shellcheck source=/dev/null
. "${CONFIGURATION}"

if [ "${TOKEN}" = '' ]; then
    echo "TOKEN not set."

    exit 1
fi

if [ "${BASE_LOCATOR}" = '' ]; then
    BASE_LOCATOR=http://localhost
fi

if [ "${DEBUG}" = true ]; then
    mkdir -p "${SCRIPT_DIRECTORY}/../tmp"
fi

export INTERFACE_LOCATOR="${BASE_LOCATOR}/api/v4"
export REQUEST="curl --silent --header content-type:application/json --header private-token:${TOKEN}"
