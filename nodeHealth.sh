#!/bin/bash

#############################
# Author: Deekshith
# Date: 12-08-2024
#
# This script for node health
#
# Version: v1
#############################

set -x #debug mode
set -e
set -o pipefail

df -h

free -g

nproc

ps -ef | grep amazon | awk -F" " '{print $2}'
