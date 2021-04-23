#!/bin/bash

# Description:  Checkout the main branch to and update it to the latests commit
#               while keeping your current local changes.
#               Add this script to your PATH environment variable before using it.
# Usage:        ./git-main.sh
# Examples:     ./git-main.sh

git fetch --all
git stash
git checkout main
git pull
git stash pop

echo "checkout to main branch finished."
echo "Happy Coding!"