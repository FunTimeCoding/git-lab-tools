#!/bin/sh -e

sudo cp tmp/dump_gitlab_backup.tar /var/opt/gitlab/backups/dump_gitlab_backup.tar
sudo chmod 600 /var/opt/gitlab/backups/dump_gitlab_backup.tar
sudo chown git:git /var/opt/gitlab/backups/dump_gitlab_backup.tar
sudo gitlab-ctl stop unicorn
sudo gitlab-ctl stop puma
sudo gitlab-ctl stop sidekiq
sudo gitlab-ctl status

echo "Confirm status is correct [y/N]"
read -r CONTINUE

if [ ! "${CONTINUE}" = y ]; then
    echo abort
fi

sudo gitlab-backup restore BACKUP=dump
sudo gitlab-ctl reconfigure
sudo gitlab-ctl start
sudo gitlab-rake gitlab:check SANITIZE=true
