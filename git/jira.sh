#!/bin/bash


## ENV VARS REQUIRED FOR EXECUTION OF GIT UTILITIES
export GIT_BRANCH_PREFIX=sathish

# check git command is available
assert_git_installed() {
  if ! command -v git 2>&1 >/dev/null; then
    error "git required for work, please install git!"
    return
  fi
}

# check .git folder available ~ git initialized
assert_git_folder() {
  if [[ ! -d ".git" ]]; then
    error "git is not initilized in this folder, run git init!"
    return
  fi
}

# url check
assert_jira_url() {
  match=$(echo $1 | awk '{if ($1 ~ /https:\/\/jira.samsungmtv.com\/browse/) {print}}')
  if [[ -z $match ]]; then
    error "jira signature should be https://jira.samsungmtv.com/browse/{ticketId}"
    return
  fi
}

# check gawk command is available
assert_gawk_installed() {
  if ! command -v gawk 2>&1 >/dev/null; then
    error "gawk is required to run the command!"
    return
  fi
}

# get branch name
get_branch_name() {
  branch=$(git rev-parse --abbrev-ref HEAD)
  echo $branch
}

# validate branch name
assert_branch_name() {
  branch=$(get_branch_name)
  # Fix this regex to use the env var
  match=$(echo $branch | awk '{if ($1 ~ /sathish\//) {print}}')
  if [[ -z $match ]]; then
    info "branch name shoud be ${GIT_BRANCH_PREFIX}/{ticketId}"
  fi
}

# get ticket id from branch
get_ticket_id_from_branch() {
  local ticketId=$(cat .git/HEAD | awk -F '/' '{print $NF}')
  echo $ticketId
}

# utility to read the ticket-id from the branch
# and prefix it as part of the commit message
jiracommit() {
  assert_git_installed
  assert_git_folder

  if [[ -z $1 ]]; then
    error "commit message is required, provide what is the fix or feature name!!"
    return
  fi

  if [[ ! -z $1 ]]; then
    assert_branch_name
    ticketId=$(get_ticket_id_from_branch)
    commitMsg=$ticketId-$1
    git diff --name-only --cached
    info "commit message: $commitMsg"
    git commit -n -m $commitMsg
  fi
}

# utility to part the jira ticket id from the url and create
# git branch with your preferred prefixer
# Example: https://jira.samsungmtv.com/browse/COM-31387
jirawork() {
  if [[ -z $1 ]]; then
    error "Jira ticket url is required!!" 1>&2
  fi

  if [[ ! -z $1 ]]; then
    info "Creating a branch to work for" $1
    assert_git_installed
    assert_git_folder
    assert_jira_url $1
    ticketId=$(echo $1 | awk '{split($0, url, "/"); print url[5]}')

    if [[ -z $ticketId ]]; then
      info "Unable to identify ticket id from" $ticketId
    fi

    if [[ ! -z $ticketId ]]; then
      git checkout -b $GIT_BRANCH_PREFIX/$ticketId
    fi
  fi
} 
