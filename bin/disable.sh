#!/bin/sh -e

sudo systemctl stop gitlab-runsvdir.service
sudo systemctl disable gitlab-runsvdir.service
