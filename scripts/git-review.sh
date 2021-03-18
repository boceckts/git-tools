#!/bin/bash

review_branch=master

# prechecks
if [ $# -lt 1 ]
then
    echo "No branch to review specified, defaulting to $review_branch."
else
    review_branch=$1
fi

git status > /dev/null 2>&1
if [ $? -ne 0 ]
then
    echo "Git not available, or current directory is not a git repository. Please install git or change into a valid git directory."
    exit 1
fi

# save working state
original_branch=$(git branch | grep \* | cut -d " " -f 2)
stash_message="Temporary stash for $original_branch during review of $review_branch"
git stash push -m "$stash_message"

# prepare review branch
git fetch --all
git checkout $review_branch
# required in case of master or previous checkout
git pull

read  -n 1 -p "Waiting until review is finished, press any key to continue..."

# restore original state
git checkout $original_branch
stash=$(git stash list | grep "$stash_message" | cut -d ":" -f 1)
if [ -z "$stash" ]
then
    echo "Nothing was stashed."
else
    git stash pop $stash
fi
#git branch -D $review_branch

echo "Review finished for branch $review_branch, back on the original branch $original_branch."
echo "Happy Coding!"
