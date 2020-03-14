#!/bin/bash

TOOLBOX=~/.toolbox

if [ -d ${TOOLBOX} ]; then
	## Common utils shared by all files
	. ${TOOLBOX}/common/log.sh
	. ${TOOLBOX}/common/utils.sh

	## Setup
	. ${TOOLBOX}/mac/installs/apps.sh
	. ${TOOLBOX}/mac/setup.sh

	. ${TOOLBOX}/nodejs/pkg.sh
	. ${TOOLBOX}/git/jira.sh

	. ${TOOLBOX}/alias/git.sh
fi

if [ ! -d ${TOOLBOX} ]; then
	## Common utils shared by all files
	. $(dirname "$0")/common/log.sh
	. $(dirname "$0")/common/utils.sh

	## Setup
	. $(dirname "$0")/mac/installs/apps.sh
	. $(dirname "$0")/mac/setup.sh

	. $(dirname "$0")/nodejs/pkg.sh
	. $(dirname "$0")/git/jira.sh

	. $(dirname "$0")/alias/git.sh
fi
