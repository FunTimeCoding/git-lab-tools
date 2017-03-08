#!/bin/sh -e

CONFIG=""

function_exists()
{
    declare -f -F "${1}" > /dev/null

    return $?
}

while true; do
    case ${1} in
        --config)
            CONFIG=${2-}
            shift 2
            ;;
        --help)
            echo "Global usage: ${0} [--help][--config CONFIG]"

            if function_exists usage; then
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

if [ "${CONFIG}" = "" ]; then
    CONFIG="${HOME}/.gitlab-tools.sh"
fi

if [ ! "$(command -v realpath 2>&1)" = "" ]; then
    REALPATH_CMD=realpath
else
    if [ ! "$(command -v grealpath 2>&1)" = "" ]; then
        REALPATH_CMD=grealpath
    else
        echo "Required tool (g)realpath not found." && exit 1
    fi
fi

CONFIG=$(${REALPATH_CMD} "${CONFIG}")

if [ ! -f "${CONFIG}" ]; then
    echo "Config missing: ${CONFIG}"

    exit 1
fi

# shellcheck source=/dev/null
. "${CONFIG}"

if [ "${TOKEN}" = "" ]; then
    echo "TOKEN not set."
    exit 1
fi

if [ "${GITLAB_URL}" = "" ]; then
    GITLAB_URL=http://localhost
fi

export API_URL="${GITLAB_URL}/api/v4"
# TODO: Remove the insecure argument.
export REQUEST="curl --silent --insecure --header content-type:application/json --header private-token:${TOKEN}"
