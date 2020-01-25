#!/bin/sh -e

sudo gitlab-ctl status
sudo gitlab-rake gitlab:env:info
sudo gitlab-rake gitlab:ldap:check RAILS_ENV=production
