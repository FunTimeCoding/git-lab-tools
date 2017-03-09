#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)

usage()
{
    echo "Usage: ${0} [--with-vendor]"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gitlab.sh"
LOCATOR="${API_URL}/projects/owned"

if [ "${1}" = --with-vendor ]; then
    WITH_VENDOR=true
else
    WITH_VENDOR=false
fi

HEADERS=$(${REQUEST} --head "${LOCATOR}")
PAGES=$(echo "${HEADERS}" | grep X-Total-Pages)
PAGES=$(echo "${PAGES#X-Total-Pages: *}" | tr -d '\r')

fetch_page()
{
    LOCAL_LOCATOR="${1}"

    if [ "${WITH_VENDOR}" = true ]; then
        QUERY="return this.path_with_namespace"
    else
        QUERY="return this.name"
    fi

    LOCAL_RESULT=$(${REQUEST} "${LOCAL_LOCATOR}" | jsawk "${QUERY}" | jq '.[]' | awk '{ gsub(/"/, "", $1); print $1 }')
    echo "${LOCAL_RESULT}"
}

if [ "${PAGES}" = 1 ]; then
    RESULT=$(fetch_page "${LOCATOR}")
else
    for PAGE in $(seq 1 "${PAGES}"); do
        PAGE_RESULT=$(fetch_page "${LOCATOR}?page=${PAGE}")

        if [ "${PAGE}" = 1 ]; then
            RESULT="${PAGE_RESULT}"
        else
        RESULT="${RESULT}
${PAGE_RESULT}"
        fi
    done
fi

echo "${RESULT}" | sort
