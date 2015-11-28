#!/bin/sh -e

DIR=$(dirname "${0}")
SCRIPT_DIR=$(cd "${DIR}"; pwd)
. "${SCRIPT_DIR}/../lib/gitlab.sh"
JSON=$(${REQUEST} "${API_URL}/projects/all")
NAMES=$(echo "${JSON}" | jsawk -n "out(this.name)")
echo "${NAMES}"
