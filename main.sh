#!/bin/bash

## Common utils shared by all files
. $(dirname "$0")/common/log.sh
. $(dirname "$0")/common/utils.sh

## Setup
. $(dirname "$0")/mac/installs/apps.sh
. $(dirname "$0")/mac/setup.sh

. $(dirname "$0")/nodejs/pkg.sh
. $(dirname "$0")/git/jira.sh

. $(dirname "$0")/alias/git.sh
