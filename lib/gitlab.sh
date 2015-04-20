#!/bin/sh -e

CONFIG=""

function_exists()
{
    declare -f -F ${1} > /dev/null
    return $?
}

while getopts "nhvc:" OPT; do
    case "${OPT}" in
        c)
            CONFIG="${OPTARG}"
            ;;
        h)
            echo "[-c config.conf] specify a config file"
            echo "[-h] print this message"
            echo "[-v] enable verbose output"
            exit 0
            ;;
        v) 
            set -x
            ;;
    esac
done

shift $((OPTIND - 1))
OPTIND=1

find_config()
{
    if [ "${CONFIG}" = "" ]; then
        CONFIG="${HOME}/.gitlab-tools.conf"
    fi

    if [ ! "$(command -v realpath 2>&1)" = "" ]; then
        REALPATH_CMD="realpath"
    else
        if [ ! "$(command -v grealpath 2>&1)" = "" ]; then
            REALPATH_CMD="grealpath"
        else
            echo "Required tool (g)realpath not found." && exit 1
        fi
    fi

    CONFIG=$(${REALPATH_CMD} "${CONFIG}")

    if [ ! -f "${CONFIG}" ]; then
        echo "Config missing: ${CONFIG}"
        exit 1;
    fi
}

find_config

. "${CONFIG}"

validate_config()
{
    if [ "${TOKEN}" = "" ]; then
        echo "TOKEN not set."
        exit 1;
    fi
}

validate_config

define_lib_vars()
{
    if [ "${GITLAB_URL}" = "" ]; then
        GITLAB_URL="http://localhost"
    fi

    export API_URL="${GITLAB_URL}/api/v3"
    export REQUEST="curl -s -H Content-Type:application/json -H PRIVATE-TOKEN:${TOKEN}"
}

define_lib_vars
