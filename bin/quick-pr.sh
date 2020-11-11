#!/bin/bash
set -e

if [[ -z $1 ]]; then
  echo "usage quick-pr.sh branchname message"
  exit 1
fi
if [[ -z $2 ]]; then
  echo "usage quick-pr.sh branchname message"
  exit 1
fi
git checkout -b $1
git add -A
git commit -m "$2"
git push -u origin $1
gh pr create --fill
