#!/bin/bash

#count=$(($1 * $2))
echo "Making $1 calls, $2 concurrently..."
seq $1 | xargs -P $2 -I NONE wget -nv -O /dev/null $3
