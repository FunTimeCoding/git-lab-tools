#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(
    cd "${DIRECTORY}"
    pwd
)

usage() {
    echo "Usage: ${0} [--with-vendor]"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/git_lab_tools.sh"
LOCATOR="${INTERFACE_LOCATOR}/projects"

if [ "${1}" = --with-vendor ]; then
    WITH_VENDOR=true
else
    WITH_VENDOR=false
fi

HEADERS=$(${REQUEST} --head "${LOCATOR}")
# GitLab uses capital letters in headers, but reverse proxies may lowercase them.
PAGES=$(echo "${HEADERS}" | grep --extended-regexp '(X-Total-Pages|x-total-pages)' | tr '[:upper:]' '[:lower:]')
PAGES=$(echo "${PAGES#x-total-pages: *}" | tr -d '\r')

fetch_page() {
    LOCAL_LOCATOR="${1}"
    LOCAL_RESULT=$(${REQUEST} "${LOCAL_LOCATOR}")

    if [ "${WITH_VENDOR}" = true ]; then
        echo "${LOCAL_RESULT}" | jq --raw-output '.[].path_with_namespace'
    else
        echo "${LOCAL_RESULT}" | jq --raw-output '.[].name'
    fi
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
