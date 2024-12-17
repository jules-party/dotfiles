#!/bin/sh

alias dot="/usr/bin/git --git-dir=$HOME/.local/src/dotfiles/ --work-tree=$HOME"

files=$(dot ls-files ~)

while IFS= read -r file
do
	dot add $file
done < <(printf '%s\n' "$files")
