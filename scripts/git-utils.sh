#!/bin/bash

function git-available() {
    git status >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        false
    else
        true
    fi
}

function exit-on-git-unavailable() {
    if ! git-available;
    then
        echo "Git not available, or current directory is not a git repository. Please install git or change into a valid git directory."
        exit 1
    fi
}
