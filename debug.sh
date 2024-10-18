#!/bin/bash
pwd
date
free -m
dockerStatus=$(systemctl status docker | awk '/Active/ {print $3}' | tr -d "[()]")
echo "this is about debugging"
echo "this $dockerStatus"
