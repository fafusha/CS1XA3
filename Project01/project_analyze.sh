#!/bin/bash

# Directories
REPO_DIR="$(git rev-parse --show-toplevel)"
OUT_DIR="$REPO_DIR/Project01/"

# Core Features
FIX_ME=0
FILE_SIZE_LIST=0
FILE_TYPE_COUNT=0
BACKUP_DELETE_RESTORE=0	
FIND_TAG=0
CHECKOUT_LATEST_MERGE=0

# Custom Feature I
FILES=()
HELP=0
FORCE=0

# Custom Feature II
CREATE_TAG=0
TAG_HOLDER=''
ADD_TAG=0
LIST_TAG=0
REMOVE_TAG=0

# Feature 6.1
for arg in "$@"
do
	case $arg in
		-fm|--fix-me)
			FIX_ME=1
			shift
			;;
		-fsl|--file-size-list)
			FILE_SIZE_LIST=1
			shift
			;;
		-ftc|--file-type-count)
			FILE_TYPE_COUNT=1
			shift
			;;
		-bdr|--backup-delete-restore)
			BACKUP_DELETE_RESTORE=1
			shift
			;;
		-clm|--checkout-latest-merge)
			CHECKOUT_LATEST_MERGE=1
			shift
			;;
		-ft|--find-tag)
			FIND_TAG=1
			shift
			;;

		#Custom Feature I
		-o|--output)
			OUT_DIR="$2"
			if [ ! -d "$OUT_DIR" ] ; then
				echo "$0: cannot access: $OUT_DIR No such directory"
				echo "$0: Check README.md for help."
				exit 1
			fi
			shift
			shift
			;;
		-h|--help)
			HELP=1
			shift
			;;
		-f|--force)
			FORCE=1
			shift
			;;

		# Custom Feature II
		-t|--tag)
			CREATE_TAG=1
			TAG_HOLDER="$2"
			shift
			shift
			;;
		-at|--add-tag)
			ADD_TAG=1
			TAG_HOLDER="$2"
			shift
			shift
			;;
		-lt|--list-tag)
			LIST_TAG=1
			TAG_HOLDER="$2"
			shift
			shift
			;;
		-rt|--remove-tag)
			REMOVE_TAG=1
			TAG_HOLDER="$2"
			shift
			shift
			;;

		-*|--*)
			echo "$0: unrecognized option:  '$1'"
			echo "$0: Check README.md for help."
			exit 1
			;;
		# Custom Feature I	
		*)
			if [ -e $1 ] ; then
				FILES+=("$1")
				shift
			else
				echo "$0: cannot access: '$1'  No such file or directory"
				echo "$0: Check README.md for help."
				exit 1
			fi
			;;
	esac
done

if [ ${#FILES[@]} -eq 0 ] ; then
	cd "$REPO_DIR"
	FILES+=(".")
fi

WDIR="${FILES[@]}"

if [ "$HELP" -eq 1 ] ; then
	echo "$0: Check README.md for in the Project01 directory"
	echo "$0: Or see on GitHub: "
	echo "$0: https://github.com/fafusha/CS1XA3/Project01/README.md"
	exit 0
fi

# Feature 6.3
if [ "$CHECKOUT_LATEST_MERGE" -eq 1 ] ; then
	git log --oneline --graph | grep -E " (M|m)(E|e)(R|r)(G|g)(E|e) "
	# Note that here outputs commit id as well as message
       	# I couldn't figure out how to extract commit id from there
	# I've tried both RegEx an glob patterns and wasn't able to make any work :(
	#
	# to checkout the needed commit I would  use
	# git checkout COMMITID
	exit 0
fi

# Feature 6.2
if [ "$FIX_ME" -eq 1 ] ; then
       	grep -l -r '.*#FIXME.*$' "$WDIR" > "$OUT_DIR/fixme.log"
	exit 0
fi

# Feature 6.4
if [ "$FILE_SIZE_LIST" -eq 1 ] ; then
	ls -R -S -G -s -h "$WDIR" | more
	exit 0	
fi

# Feature 6.5
if [ "$FILE_TYPE_COUNT" -eq 1 ] ; then
	read -p "$0: Enter extension: " FTYPE
	if [ "$FORCE" -eq 0 ] ; then
		if [[ $FTYPE == *[[:space:]]* ]]
		then
			echo "$0: Inavlid extension: '$FTYPE'"
	       		echo "$0: Check README.md for help."
			exit 1
		fi
	fi
		echo "Files with extension $FTYPE:"
		ls -r "$WDIR"| grep ".*\.$FTYPE$" | wc -l
	exit 0	
fi

# Feature 6.6
if [ "$FIND_TAG" -eq 1 ] ; then
	read -p "$0: Eneter tag: " TAG
	find "$WDIR" -name "*.py" -print0 | xargs -0 grep -E "\#.*$TAG.*" > "$OUT_DIR/Tag.log"
	exit 0
fi

# Feature 6.8
if [ "$BACKUP_DELETE_RESTORE" -eq 1 ] ; then
	
	read -p "$0: Enter 'b' to Backup and Delete,'r' to Restore: " INP

	if [ "$INP" == "b" ] ; then
		# backup dir init
		if [ -d "$OUT_DIR/backup" ] ; then
			rm -r "$OUT_DIR/backup"
		fi
		mkdir "$OUT_DIR/backup"
		# Find all .tmp files and store paths
		find "$WDIR" -name "*.tmp" > "$OUT_DIR/backup/restore.log"
		# Copy all files
		cat "$OUT_DIR/backup/restore.log" | xargs -i cp '{}' "$OUT_DIR/backup"
		# Remove files
		cat "$OUT_DIR/backup/restore.log" | xargs rm 
	elif [ "$INP" == "r" ] ; then

		if [ ! -d "$OUT_DIR/backup" ] ; then
			echo "$0: backup directory does not exists"
			echo "$0: Check README.md for help."
			exit 1
		fi
		out_files=$(ls "$OUT_DIR/backup" --ignore="restore.log" -1)
		# Note that here just lists the names of the files
		# To restore these files we need to use cp to copy files
		# and use grep with RegEX in order to extract file paths
	        # of the asscociated files restore.log
		# Unofrtunatly I was uanble to make them work together :(
		echo "$out_files"
	else
		echo "$0: Unrecognized option: $INP"
		echo "$0: Check README.md for help."
		exit 1 

	fi
	exit 0
fi


# Custom Feature II
if [ "$CREATE_TAG" -eq 1 ] ; then
	if [ "$FORCE" -eq 0 ] ; then

		if [ ! "$WDIR" == "." ] ; then
			echo "$0: Invalid arguments: $WDIR"
			echo "$0: Check README.md for help."
			exit 1
		fi
		if [ ! -d "$REPO_DIR/.tag" ] ; then
			mkdir "$REPO_DIR/.tag"
		fi
		if [ -f "$REPO_DIR/.tag/$TAG_HOLDER" ] ; then
			echo "$0: Tag already exists: $TAG_HOLDER"
			echo "$0: Check README.md for help."
			exit 1
		fi
	fi
	touch "$TAG_HOLDER" "$REPO_DIR/.tag"
	exit 0
fi

if [ "$ADD_TAG" -eq 1 ] ; then
	if [ "$FORCE" -eq 0 ] ; then
		if [ "$WDIR" == "." ] ; then
			echo "$0: No files specified."
			echo "$0: Check README.md for help."
			exit 1
		fi
		if [ ! -f "$REPO_DIR/.tag/$TAG_HOLDER" ] ; then
			echo "$0: No such tag exists: $TAG_HOLDER"
			echo "$0: Check README.md for help." 
			exit 1 
		fi
	fi
	echo "$($WDIR)" >> "$REPO_DIR/.tag/$TAG_HOLDER"
	exit 0
fi

if [ "$LIST_TAG" -eq 1 ] ; then
	if [ "$FORCE" -eq 0 ] ; then
		if [ ! "$WDIR" == "." ] ; then
			echo "$0: Invlaid arguments: $WDIR"
			echo "$0: Check README.md for help."
			exit 1
		fi
		if [ ! -f "$REPO_DIR/.tag/$TAG_HOLDER" ] ; then
			echo "$0: No such tag exists: $TAG_HOLDER"
			echo "$0: Check README.md for help"
			exit 1
		fi
	fi
	cat "$REPO_DIR/.tag/$TAG_HOLDER"
	exit 0

fi

if [ "$REMOVE_TAG" -eq 1 ] ; then
	if [ "$FORCE" -eq 0 ] ; then
		if [ ! -f "$REPO_DIR/.tag/$TAG_HOLDER" ] ; then
			echo "$0: No such tag exists: $TAG_HOLDER"
			echo "$0: Check README.md for help."
			exit 1
		fi
	fi
	rm "$REPO_DIR/.tag/$TAG_HOLDER"

fi
