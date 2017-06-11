#!/bin/sh -e

# shellcheck disable=SC2016
jjm --locator https://github.com/FunTimeCoding/gitlab-tools.git --build-command ./build.sh --checkstyle 'build/log/checkstyle-*.xml' > job.xml
