#!/bin/bash

cd $HOME/dotfiles

git add .
git commit -m "`date`"
git push
