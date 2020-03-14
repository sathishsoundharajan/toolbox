read -r -p "Are you sure you want to remove Toolbox ? [y/N] " confirmation
if [ "$confirmation" != y ] && [ "$confirmation" != Y ]; then
	echo "Uninstall cancelled"
	exit
fi

echo "Removing ~/.toolbox"
if [ -d ~/.toolbox ]; then
	rm -rf ~/.toolbox
fi

echo "Thanks for trying out Toolbox. It's been uninstalled."
echo "Don't forget to restart your terminal!"
