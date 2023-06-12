############################################################################
# Author Name: Seth Cram
# Date: 11/03/2021 
# File: Backup.sh
#
# Goal:
#  Write a script to backup files and directories into a special
#   subdirectory (.backup). Your backup script should handle the case of 
#   an existing file or directory of the same name in the subdirectory
#   .backup.
#
# Project Description:
#  Creates a .backup dir in user's home directory if doesn't already exist. 
#   Copies the passed in file or directory to the backup directory. If 
#   naming conflicts, prompts user about whether to overwrite the backed-up
#   file/dir or not back up the file/dir at all.  
#  
# Clarifications:
#  If user decides not to overwrite existing file/dir, passed in file/dir
#   is not backed up. 
#
# Possible Expansion:
#  Could take in multiple files and/or directories at one time from cmd line
#
############################################################################

#!/bin/bash

#store backup dir path:
backupDir=$HOME/.backup

#if backup directory doesn't exist:
if [ ! -e $backupDir ]
then
    #make backup directory:
    mkdir $backupDir

    #Testing: echo backup dir created
#Testing: else
    #Testing: echo backup dir already exists
fi

#if number of args < 1:
if [ $# -lt 1 ]
then 
    echo Pass a directory or file to the script.

    exit #failed
fi

item=$1 #store item passed in

#if passed in a dir:
if [ -d "$item" ]
then 

    #Testing: echo "Passed in $item is a directory."

    #if backup directory already exists:
    if [ -e "$backupDir"/"$item" ]
    then
	echo "$item" is already backed up. 
	
	echo "cp: overwrite '"$backupDir"/"$item"'?"

	read overwrite #store user input in 'overwrite'

	#if user wants to overwrite:
	if [ overwrite == "yes" ]
	then
	    #recursively copy item into backup dir:
	    cp -r "$item" "$backupDir"/"$item"

	fi

    else #this backup dir doesn't exist
	
	#recursively copy item into backup dir:
        cp -r "$item" "$backupDir"/"$item"
    fi

#if passed in a file:
elif [ -f "$item" ]
then 

    #Testing: echo "Passed in $item is a file."

    #copy item into back dir:
    cp -i "$item" "$backupDir"/"$item" #prompts if overwriting
    
fi
