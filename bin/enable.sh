#!/bin/sh -e

sudo systemctl enable gitlab-runsvdir.service
sudo systemctl start gitlab-runsvdir.service
