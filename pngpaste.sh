#!/bin/sh

name="${1}" extension="${2:-png}" class="${3}" 
test -z "$class" && class='«class PNGf»' 
stdout='' 
if [[ "$name" == '-' ]]
then
    name="$(gmktemp --suffix ".${extension}")"  || return $?
    stdout=y 
fi

dir="$(dirname "$name")" 
if test -z "$dir"
then
    dir="$PWD" 
fi
dir="$(realpath "$dir")" 
mkdir -p "$dir" || return $?
name="$(basename "$name")" 
if test -z "${name}"
then
    name+="some"  || return $?
fi
[[ "$name" =~ '\.'${extension}'$' ]] || name+=".${extension}" 
f="${dir}/${name}" 
if test -e "$f"
then
    command rm "$f"
fi
osascript -e "tell application \"System Events\" to ¬
              write (the clipboard as ${class}) to ¬
                      (make new file at folder \"${dir}\" with properties ¬
                              {name:\"${name}\"})" || return $?
if test -n "$stdout"
then
    cat "$f"
    command rm "$f"
fi
