#!/bin/bash

#TODO
#IMPT
# A)
# - Account for directories/files including special characters
#   (i.e. whitespace)
# 
# B)
# - Account for directories/files not existing/already existing 
#
# C)
# - Account for command IO failure


# Undocumented features
# 
# Ability to change directorires, make wdir and odir
# Make the set by last argument account for odir and wdir separetly


# TODO
# Feature Ideas
# 
# Do standart output thingies...

#Variables
#DDIR: default directory
#WDIR: working directory
#ODIR: output directory

#FIXME
#
# Fix directories, make it an argument, default to .
# Works temporarirle
#


# Think about directories more, possibly an error here
DDIR='/home/rapopord/private/CS1XA3/Project01/'
WDIR="$DDIR"
ODIR="$DDIR"
#cd "$WDIR"

# make take flags with arguments
#
# consider using swithc case staements
for arg in "$@"
do
	case $arg in
		-fm|--fixme)
			# FIXME
			# Fix issue with directories
			# Make custom directory io with |
			grep -l -R '.*#FIXME.*$'  > "fixme.log"
			shift
		;;
		-fsl|--file-size-list)
			#FIXME
			# Fix issues with directories
			# Makke custom directory io
			ls -S -s -h | more
			shift
		;;
		-ftc|--file-type-count)
			#FIXME
			#
			#Do nice output
			#
			# Fix issue with directories
			read -p $'Enter extension\n' fileext
			ls -r | grep ".*\.$fileext\b" | wc -l
			shift
		;;
	esac
done
