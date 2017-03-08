#!/bin/sh -e

~/src/jenkins-tools/bin/delete-job.sh gitlab-tools || true
~/src/jenkins-tools/bin/put-job.sh gitlab-tools job.xml
