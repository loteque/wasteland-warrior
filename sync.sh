#!/bin/bash

# get the directory this file is in
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Desc: Syncs assets from the server to the local machine
rclone sync wasteland-warrior:assets $DIR/project/assets