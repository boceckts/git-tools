#!/bin/bash

# Description:  Stashes local changes and checks out the specified branch
#               for review by soft resetting the review branch to the number
#               of specified commits. Review branch will default to master
#               and number of commits to review will default to 1 if not specified.
#               Add this script to your PATH environment variable before using it.
# Usage:        git-review [git-branch] [commits]
# Examples:     git-review
#               git-review develop/review-branch
#               git-review develop/review-branch 2

function git-review() {

    # git-utils.h scripts needs to be sourced first
    git-available

    review_branch=master
    review_commits=1

    # prechecks
    if [ $# -lt 1 ]
    then
        echo "No branch to review specified, defaulting to $review_branch."
        echo "No review range specified, defaulting to $review_commits."
    elif [ $# -eq 1 ]
    then
        review_branch=$1
        echo "No review range specified, defaulting to $review_commits."
    elif [ $# -eq 2 ]
    then
        review_branch=$1
        if [[ $2 =~ ^[0-9]{1}$ ]]
        then
            review_commits=$2
        else
            echo "Invalid review range specified, defaulting to $review_commits. The review range only allows values between 0 and 9 commits."
        fi
    else
        review_branch=$1
        if [[ $2 =~ ^[0-9]{1}$ ]]
        then
            review_commits=$2
        else
            echo "Invalid review range specified, defaulting to $review_commits. The review range only allows values between 0 and 9 commits."
        fi
    fi

    # save working state
    original_branch=$(git branch | grep \* | cut -d " " -f 2)
    stash_message="Temporary stash for $original_branch during review of $review_branch"
    git stash push -m "$stash_message"

    # prepare review branch
    git fetch --all
    git checkout $review_branch
    ## required in case of master or previous checkout
    git pull
    ## use a soft reset to easily indicate changed files
    git reset --soft HEAD~$review_commits

    read  -n 1 -p "Waiting until review is finished, press any key to continue..."

    # restore original state
    git reset --hard $review_branch
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

}
