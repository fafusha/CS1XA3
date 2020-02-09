#!/bin/bash

WDIR="$1"
cd "$WDIR"

if [  $2 -eq 2 ] ; then
	grep -r -L '#FIXME' .  > fixme.log
fi
