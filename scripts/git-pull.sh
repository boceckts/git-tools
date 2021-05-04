#!/bin/bash

# Description:  Update the current branch to the latests commit
#               while keeping your current local changes.
#               Add this script to your PATH environment variable before using it.
# Usage:        git-pull
# Examples:     git-pull

function git-pull() {

     # git-utils.h scripts needs to be sourced first
    git-available

    git fetch --all
    git stash
    git pull
    git stash pop

    echo "Pulling changes finished."
    echo "Happy Coding!"

}
