#!/bin/bash

# Description:  Rebases the current branch to a specified (remote) branch by checking
#               out a temporary branch, hard resetting the current branch to the rebase
#               branch and cherry picking the number of specified commits from the
#               temporary branch.
#               Add this script to your PATH environment variable before using it.
# Usage:        git-super-rebase [git-branch] [commits]
# Examples:     git-super-rebase
#               git-super-rebase origin/master
#               git-super-rebase origin/master 2

source git-utils.sh

function git-super-rebase() {

     # git-utils.h scripts needs to be sourced first
    git-available

    rebase_branch=origin/master
    rebase_commits=1

    # prechecks
    if [ $# -lt 1 ]
    then
        echo "No branch to rebase specified, defaulting to $rebase_branch."
        echo "No rebase range specified, defaulting to $rebase_commits."
    elif [ $# -eq 1 ]
    then
        rebase_branch=$1
        echo "No rebase range specified, defaulting to $rebase_commits."
    elif [ $# -eq 2 ]
    then
        rebase_branch=$1
        if [[ $2 =~ ^[0-9]{1}$ ]]
        then
            rebase_commits=$2
        else
            echo "Invalid rebase range specified, defaulting to $rebase_commits. The rebase range only allows values between 0 and 9 commits."
        fi
    else
        rebase_branch=$1
        if [[ $2 =~ ^[0-9]{1}$ ]]
        then
            rebase_commits=$2
        else
            echo "Invalid rebase range specified, defaulting to $rebase_commits. The rebase range only allows values between 0 and 9 commits."
        fi
    fi

    current_branch=$(git branch --show-current)
    temp_branch=_temp_$current_branch

    # checkout temporary branch
    git fetch --all
    git checkout -b $temp_branch
    git checkout $current_branch
    git reset --hard $rebase_branch 
    git log $temp_branch --pretty=format:'%h' -n $rebase_commits | xargs git cherry-pick --strategy=resolve

    echo "rebase for $current_branch to $rebase_branch finished."
    echo "Happy Coding!"

}
