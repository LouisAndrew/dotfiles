#!/bin/sh

declare result=$1

ifsOld=$IFS
IFS=":"

read filename linenumber content <<< "$result"
$DOTFILES_PATH/batpager.sh $filename $linenumber

IFS=$ifsOld
