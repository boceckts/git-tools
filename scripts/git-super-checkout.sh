#!/bin/bash

# Description:  Checkout a branch and update it to the latests commit
#               while keeping your current local changes.
#               Add this script to your PATH environment variable before using it.
# Usage:        ./git-super-checkout.sh [branch]
# Examples:     ./git-super-checkout.sh develop

branch_name=main

if [ $# -lt 1 ]
then
    echo "No branch name to checkout specified, defaulting to $branch_name."
    echo "No rebase range specified, defaulting to $branch_name."
fi

git fetch --all
git stash
git checkout $branch_name
git pull
git stash pop

echo "checkout to $branch_name branch finished."
echo "Happy Coding!"