# utility to get tag from the package.json
tag() {
  version=$(get_pkg_version)
  info $version
  git add package.json
  git diff --name-only --cached
  commitMsg="v"$version
  info "commit message: $commitMsg"
  git commit -n -m $commitMsg
}
