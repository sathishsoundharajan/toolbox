command_exists() {
	local installed=$(command -v $1)
	echo $installed
}
