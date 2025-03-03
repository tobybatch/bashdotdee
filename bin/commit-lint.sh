#!/bin/bash

# Validate commit message format
validate_commit_message() {
    local commit_msg_file="$1"
    local commit_msg=$(cat "$commit_msg_file")

    # Enforce Conventional Commits format (e.g., "feat: add new feature")
    if ! echo "$commit_msg" | grep -qE "^(feat|fix|docs|style|refactor|test|chore): .+"; then
        echo "ERROR: Commit message does not follow the required format."
        echo "Example: 'feat: add new feature'"
        exit 1
    fi

    # Enforce that the first letter after the colon is not capitalized
    if echo "$commit_msg" | grep -qE "^(feat|fix|docs|style|refactor|test|chore): [A-Z]"; then
        echo "ERROR: The first letter after the colon must not be capitalized."
        echo "Example: 'feat: add new feature' (not 'feat: Add new feature')"
        exit 1
    fi

    # Enforce no trailing full stop
    if echo "$commit_msg" | grep -qE "\.$"; then
        echo "ERROR: Commit message must not end with a trailing full stop."
        echo "Example: 'feat: add new feature' (not 'feat: add new feature.')"
        exit 1
    fi
}

if [ "$1" == "install" ]; then
  if [ -d "./.git/hooks" ]; then

    exit 0
  fi
  echo "❌ Not a git repo, can't install"
fi

# Main script
commit_msg_file="$1"
if [[ -z "$commit_msg_file" ]]; then
    echo "Usage: $0 <commit-message-file>"
    exit 1
fi

validate_commit_message "$commit_msg_file"
echo "Commit message is valid!"
exit 0
