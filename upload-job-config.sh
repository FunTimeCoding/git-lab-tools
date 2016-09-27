#!/bin/sh -e

~/Code/Personal/jenkins-tools/bin/delete-job.sh gitlab-tools || true
~/Code/Personal/jenkins-tools/bin/put-job.sh gitlab-tools job.xml
