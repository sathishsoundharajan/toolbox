set -e

# Default settingsZSH=${ZSH:-~/.oh-my-zsh}
TOOLBOX=${TOOLBOX:-~/.toolbox}
REPO=${REPO:-sathishsoundharajan/toolbox}
REMOTE=${REMOTE:-https://github.com/${REPO}.git}
BRANCH=${BRANCH:-master}

command_exists() {
	command -v "$@" >/dev/null 2>&1
}

error() {
	echo ${RED}"[Toolbox]:error: $@"${RESET} >&2
}

info() {
	echo ${BLUE}"[Toolbox]:info: $@"${RESET}
}

setup_color() {
	# Only use colors if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		RESET=""
	fi
}

setup_toolbox() {
	umask g-w,o-w

	info "Cloning toolbox.."

	command_exists git || {
		error "git is not installed"
		exit 1
	}

	git clone -c core.eol=lf -c core.autocrlf=false \
		-c fsck.zeroPaddedFilemode=ignore \
		-c fetch.fsck.zeroPaddedFilemode=ignore \
		-c receive.fsck.zeroPaddedFilemode=ignore \
		--depth=1 --branch "$BRANCH" "$REMOTE" "$TOOLBOX" || {
		error "git clone of toolbox repo failed"
		exit 1
	}

	echo
}

append_toolbox_main() {
	echo ${TOOLBOX}/main.sh >> ~/.zshrc
}

main() {
	setup_color
	setup_toolbox

	info "source main shell - $TOOLBOX/main.sh"
	source $TOOLBOX/main.sh

	mac_setup
	append_toolbox_main
	info "installation completed. Try toolbox"
}

main "$@"
