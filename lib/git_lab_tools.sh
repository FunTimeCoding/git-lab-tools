#!/bin/sh -e

CONFIGURATION=""

while true; do
    case ${1} in
        --configuration)
            CONFIGURATION=${2-}
            shift 2
            ;;
        --help)
            echo "Global usage: ${0} [--help][--configuration CONFIGURATION]"

            if command -v usage > /dev/null; then
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

if [ "${TOKEN}" = "" ]; then
    echo "TOKEN not set."

    exit 1
fi

if [ "${BASE_LOCATOR}" = "" ]; then
    BASE_LOCATOR=http://localhost
fi

if [ "${INTERFACE_VERSION}" = "" ]; then
    INTERFACE_VERSION=4
fi

export INTERFACE_LOCATOR="${BASE_LOCATOR}/api/v${INTERFACE_VERSION}"
# TODO: Remove the insecure argument.
export REQUEST="curl --silent --insecure --header content-type:application/json --header private-token:${TOKEN}"
