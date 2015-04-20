#!/bin/sh -e

SCRIPT_DIR=$(cd "$(dirname "${0}")"; pwd)
. "${SCRIPT_DIR}/../lib/gitlab.sh"
JSON=$(${REQUEST} "${API_URL}/projects/all")
NAMES=$(echo "${JSON}" | jsawk -n "out(this.name)")
echo "${NAMES}"
