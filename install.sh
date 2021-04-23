#!/bin/bash

# Add a source entry for each script in the scripts directorys
installed=$(cat ~/.bash_profile | grep "for FILE in $(pwd)/scripts")

if [ $? -eq 0 ]
then
    echo "Scripts are already installed, nothing to do."
else
    echo >> ~/.bash_profile
    echo "for FILE in $(pwd)/scripts/* ; do source $FILE ; done" >> ~/.bash_profile
    echo "Scripts are now installed, save time and have fun!"
fi
