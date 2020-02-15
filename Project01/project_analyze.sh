#!/bin/bash

REPO_DIR="$(git rev-parse --show-toplevel)"
OUT_DIR="$REPO_DIR/Project01/"
# Feature 6.1
FIX_ME=0
FILE_SIZE_LIST=0
FILE_TYPE_COUNT=0
FILES=()
for arg in "$@"
do
	case $arg in
		-fm|--fixme)
			FIX_ME=1
			shift
			;;
		-fsl|--file-size-list)
			FILE_SIZE_LIST=1
			shift
			;;
		-ftc|--file-type-coun)
			FILE_TYPE_COUNT=1
			shift
			;;
		-*|--*)
			echo "$0: unrecognized option:  '$1'"
			echo "Check README.md for help."
			exit 1
			;;
		*)
			if [ -e $1 ] ; then
				FILES+=("$1")
				shift
			else
				echo "$0: cannot access: '$1'  No such file or directory"
				echo "Check README.md for help."
				exit 1
			fi
			;;
	esac
done

# Checking if any FILES were passed as args
if [ ${#FILES[@]} -eq 0 ] ; then
	cd "$REPO_DIR"
	FILES+=(".")
fi

WDIR="${FILES[@]}"

# Feature 6.2
if [ "$FIX_ME" -eq 1 ] ; then
       	grep -l -r '.*#FIXME.*$' "$WDIR" > "$OUT_DIR/fixme.log"
fi

# Feature 6.4
if [ "$FILE_SIZE_LIST" -eq 1 ] ; then
	ls -R -S -G -s -h "$WDIR" | more	
fi

# Feature 6.5
if [ "$FILE_TYPE_COUNT" -eq 1 ] ; then
	read -p "$0: Enter extension: " FTYPE
	if [[ $FTYPE == *[[:space:]]* ]]
	then
		echo "$0: Inavlid extension: '$FTYPE'"
	       	echo "$0: Check README.md for help."
		exit 1
	fi
	echo "Files with extension $FTYPE:"
	ls -r "$WDIR"| grep ".*\.$FTYPE$" | wc -l 
fi
