#!/bin/bash

# Description:  Checkout a branch and update it to the latests commit
#               while keeping your current local changes.
#               Add this script to your PATH environment variable before using it.
# Usage:        git-checkout [branch]
# Examples:     git-checkout develop

function git-checkout() {

     # git-utils.h scripts needs to be sourced first
    git-available

    branch_name=main

    if [ $# -lt 1 ]
    then
        echo "No branch name to checkout specified, defaulting to $branch_name."
        echo "No rebase range specified, defaulting to $branch_name."
    else
        branch_name=$1
    fi

    git fetch --all
    git stash
    git checkout $branch_name
    git pull
    git stash pop

    echo "checkout to $branch_name branch finished."
    echo "Happy Coding!"

}

function git-main() {
    git-checkout "main"
}

function git-master() {
    git-checkout "master"
}
