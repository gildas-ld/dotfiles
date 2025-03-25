#!/usr/bin/env zsh

# Colors
NC="\033[0m"
RED="\033[0;31m"

# Displays an error message and exits the script
die() {
	clear
	echo -e "${RED}$* ${NC}\n" >&2
	exit 2
}

# Safely remove a path
safe_rm() {
	rm -rf "$1"
}

# Creates a symbolic link after deletion
link() {
	safe_rm "$2"
	ln -srfv "$1" "$2"
}

# Updates git submodules
update_submodules() {
  git submodule update --init --checkout --force --recursive --remote --verbose
  git submodule sync --recursive
  git submodule foreach '
    echo "Updating submodule in $(pwd)"
    # Save local uncommitted changes
    git stash push --include-untracked -m "Auto stash before rebase"
    # Get the current branch name
    BRANCH=$(git symbolic-ref --short -q HEAD)
    # If no branch is found, try switching to main or master
    if [ -z "$BRANCH" ]; then
      if git show-ref --verify --quiet refs/heads/main; then
        echo "Switching to main branch"
        git checkout main
        BRANCH="main"
      elif git show-ref --verify --quiet refs/heads/master; then
        echo "Switching to master branch"
        git checkout master
        BRANCH="master"
      else
        echo "No 'main' or 'master' branch found"
        exit 1
      fi
    fi
    git fetch origin "$BRANCH"
    git rebase origin/"$BRANCH"
    # Restore the stash if it was created
    if git stash list | grep -q "Auto stash before rebase"; then
      git stash pop
    fi
  '
}
