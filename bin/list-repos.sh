#!/bin/sh -e

SCRIPT_DIR=$(cd "$(dirname "${0}")"; pwd)
. "${SCRIPT_DIR}/../lib/gitlab.sh"
JSON=$(${REQUEST} "${API_URL}/projects/owned")
NAMES=$(echo "${JSON}" | jsawk -n "out(this.name)")
echo "${NAMES}"
