############################################################################
# Author Name: Seth Cram
# Date: 11/03/2021 
# File: Rm_Underscores.sh
#
# Goal:
#  Write a script to change file names: file_1.cpp → file1.cpp
#   remove any/all underscores in C/C++ files in a directory.
#
# Project Description:
#  A directory is passed in when the script is run. It errors if less than
#   one argument or a directory wasn't passed in. Otherwise, all C/C++ 
#   file names within that directory have their underscores removed. 
#
# Clarifications:
#  This program assumes that every file extension that starts with c or C
#   is a C/C++ file. Header Files aren't considered C/ C++ files. Any naming
#   conflicts are resolved by overwriting the pre-existing file.
#
# Possible Expansion:
#  Could prompt user for action w/ overwriting a file with the same name.
#
############################################################################

#!/bin/bash

#if number of args < 1:
if [ $# -lt 1 ]
then 
    echo Pass a directory to the script.

    exit #failed
fi

dir=$1 #store directory

#if didn't pass in a dir:
if [ ! -d "$dir" ]
then 

    echo "Passed in $dir isn't a directory."
    echo "Pass in a directory to the script."

    exit #failed

#testing: else #did pass in a dir

    #testing: echo "$dir is a directory"

fi

#declare files array:
declare -a files

#store all paths in directory with an underscore in their file name:
files=("$dir"/*_*)

numOfFiles=${#files[*]}

#Testing: echo Contents of directory: echo ${files[*]}

#Testing: echo "First two elly's:" echo ${files[0]} echo ${files[1]}

i=0 #counting variable

while test $i -lt $numOfFiles #loop thru each file index
do
    #store file name of each file path:
    cleanedFile=`basename "${files[$i]}"`

    #echo pre-cleanedFile: $i "$cleanedFile"

    #if it's a c or c++ file:
    if [[ "$cleanedFile" == *".c"* || "$cleanedFile" == *".C"* ]]
    then
	#remove underscores:
	cleanedFile=`echo "$cleanedFile" | tr -d '_'`

	#Testing: echo cleanedFile: $i "$cleanedFile"

	#change original files into file name w/o underscores:
	mv "${files[$i]}" $dir/"$cleanedFile"

    fi  

    i=`expr $i + 1` #increment i
done



