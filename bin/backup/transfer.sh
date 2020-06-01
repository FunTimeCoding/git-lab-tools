#!/bin/sh -e

HOST="${1}"
PORT="${2}"

if [ "${HOST}" = '' ] || [ "${PORT}" = '' ]; then
    echo "Usage: ${0} HOST PORT"

    exit 1
fi

scp -P "${PORT}" tmp/dump_gitlab_backup.tar "${HOST}:~/src/git-lab-tools/tmp"
