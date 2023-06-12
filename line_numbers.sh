############################################################################
# Author Name: Seth Cram
# Date: 11/03/2021 
# File: line_numbers.sh
# Goal:
#   Write a script to allow both the addition and removal of line numbers
#    from a text file. 
#    NOTE: The nl or sed command may not be used.
#
# Project Description:
#   This script needs to be run with an option to specify line number
#    removal (-r) or addition (-a). This needs to be specified before the
#    file is passed in. File I/O is used to replace the changed file.
#    
# Clarifications:
#   If no line numbers are present and removal is specified, unexpected
#    behavior may occur. This script only supports the removal of line
#    numbers added by this script. Two ways to add and remove lines are
#    present, but only one is uncommented & used. Formatting is not 
#    preserved when removing line numbers.
#
# Possible Expansion:
#   Could pass in more than one file at a time or a directory.
#   Could add support for other types of line numbers.
#    Such as line numbers with a period after them and 
#    those with 0 before the single digit numbers.
#   Could preserve document formatting after line number removal. 
############################################################################

#!/bin/bash

#if number of args < 1:
if [ $# -lt 2 ]
then 
    echo Pass an option, then file to the script.

    exit #failed
fi

op=$1 #store option
iFile=$2 #store input file

#if didn't passed in a file:
if [ ! -f "$iFile" ] #get the value as a string (can use -e to check if exists)
then 

    echo "Passed in $iFile isn't a file"
    echo "Pass in a file to the script."

    exit #failed

#testing: else #did pass in a file

    #testing: echo "$iFile is a file"

fi

#display contents of passed in file:
#cat "$iFile"

#store new changed contents in 'ph.txt':
case $op in 
    "-a")  #add line numbers

	#add line number to start of each line:
	awk '{print NR,$0}' "$iFile" > ph.txt

	#cat by adding line numbers:
	#cat -n "$iFile" > ph.txt

	;;
    "-r")  #remove line numbers

	#remove the 1st word of each line if it's a line number:
	awk '{ 
               if( $1 != NR && 1 < NF )
                 printf $1 " ";
               for( i=2; i < NF; i++ ) 
               {
                    printf $i " "; 
               }
              if( $1 == $NF &&  $1 == NR )
               {
                    printf "\n"
               }
              else
               {
                  print $NF 
               } }' "$iFile" > ph.txt
	#if the first word isn't a line number, dont remove it
	#print every word after the first, but not the last 
	#then if the first word is the last word and a line number, 
	# recreate the distroyed empty line
	# else, print the last word

	#cut only the 1st word from the output of each line:
	#cut -d " " -f 2- "$iFile" > ph.txt

	;;
    *)
	#default case:
	echo $op is not a valid option.
	
	exit

	;;
esac

#display contents of placeholder file: 
#cat "ph.txt"

#overwrite input file with changed ouput file:
mv "ph.txt" "$iFile"

#display contents of changed input file: 
#cat "$iFile"


