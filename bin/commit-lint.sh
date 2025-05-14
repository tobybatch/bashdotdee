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

# Installation mode
if [ "$1" == "install" ]; then
    if [ -d "./.git" ]; then
        cp "$0" ./.git/hooks/pre-commit
        chmod +x ./.git/hooks/pre-commit
        echo "✅ Pre-commit hook installed successfully"
        exit 0
    else
        echo "❌ Not a git repository, can't install hook"
        exit 1
    fi
fi

# Main script - handle both direct invocation and hook execution
if [ -n "$GIT_PARAMS" ]; then
    # Git < 1.8.2 passes commit message via GIT_PARAMS
    validate_commit_message "$GIT_PARAMS"
elif [ -n "$1" ]; then
    # Git >= 1.8.2 passes commit message as argument
    validate_commit_message "$1"
else
    # Fallback: try to get the commit message file from git
    commit_msg_file=$(git rev-parse --git-path COMMIT_EDITMSG)
    if [ -f "$commit_msg_file" ]; then
        validate_commit_message "$commit_msg_file"
    else
        echo "Error: Could not determine commit message file location"
        exit 1
    fi
fi
