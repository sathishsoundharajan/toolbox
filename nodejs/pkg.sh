#!/bin/bash

pkg_file='package.json'

setup_pkg() {
  if ! command -v jq 2>&1 >/dev/null; then
    echo "jq not found, installing jq!"
    brew install jq
  fi
}

assert_pkg_file() {
  if [[ ! -f $pkg_file ]]; then
    echo "$pkg_file not found, please make sure the path"
    return
  fi
}

get_pkg_version() {
  assert_pkg_file
  current_version=$(cat $pkg_file | jq ".version" | awk '{gsub("\"", "", $0); print}')
  echo $current_version
}

majorbump() {
  version=$(get_pkg_version)
  updated_version=$(echo $version | awk '{split($0, a, "."); { a[1] = a[1] + 1 } str = a[1]; for(i = 2; i <= 3 - 1; i++) { str = str "." a[i] } print str "." a[3] }')
  echo Updating version to: $updated_version
  json=$(cat $pkg_file | jq ".version = "\"${updated_version}\""")
  echo $json >$pkg_file
}

minorbump() {
  version=$(get_pkg_version)
  updated_version=$(echo $version | awk '{split($0, a, "."); { a[2] = a[2] + 1 } str = a[1]; for(i = 2; i <= 3 - 1; i++) { str = str "." a[i] } print str "." a[3] }')
  echo Updating version to: $updated_version
  json=$(cat $pkg_file | jq ".version = "\"${updated_version}\""")
  echo $json >$pkg_file
}

patchbump() {
  version=$(get_pkg_version)
  updated_version=$(echo $version | awk '{split($0, a, "."); { a[3] = a[3] + 1 } str = a[1]; for(i = 2; i <= 3 - 1; i++) { str = str "." a[i] } print str "." a[3] }')
  echo Updating version to: $updated_version
  json=$(cat $pkg_file | jq ".version = "\"${updated_version}\""")
  echo $json >$pkg_file
}

custombump() {
  unset ACTION

  while getopts 'n' c; do
    case $c in
    n) ACTION=NEW ;;
    esac
  done

  if [ -n "$ACTION" ]; then
    case $ACTION in
    NEW) custom_bump_new ;;
    esac
  fi

  if [ ! -n "$ACTION" ]; then
    version=$(get_pkg_version)
    updated_version=$(echo $version | awk '{split($0, a, "."); { a[length(a)] = a[length(a)] + 1 } str = a[1]; for(i = 2; i <= length(a) - 1; i++) { str = str "." a[i] } print str "." a[length(a)] }')
    echo Updating version to: $updated_version
    json=$(cat $pkg_file | jq ".version = "\"${updated_version}\""")
    echo $json >$pkg_file
  fi
}

custom_bump_new() {
  version=$(get_pkg_version)
  updated_version=$(echo $version | awk '{split($0, a, "."); { a[length(a) + 1] = 1 } str = a[1]; for(i = 2; i <= length(a) - 1; i++) { str = str "." a[i] } print str "." a[length(a)] }')
  echo Updating version to: $updated_version
  json=$(cat $pkg_file | jq ".version = "\"${updated_version}\""")
  echo $json >$pkg_file
}
