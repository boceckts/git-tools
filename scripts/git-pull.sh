#!/bin/bash

# Description:  Update the current branch to the latests commit
#               while keeping your current local changes.
#               Add this script to your PATH environment variable before using it.
# Usage:        git-pull
# Examples:     git-pull

function git-pull() {

    # git-utils.h scripts needs to be sourced first
    exit-on-git-unavailable

    stash_message="Temporary stash during pull of remote changes at $(date "+%d%m%y%H%M%S")"

    git fetch --all
    git stash push -m "$stash_message"
    git pull
    stash=$(git stash list | grep "$stash_message" | cut -d ":" -f 1)
    if [ -z "$stash" ]
    then
        echo "Nothing was stashed."
    else
        git stash pop $stash
    fi

    echo "Pulling changes finished."
    echo "Happy Coding!"

}
