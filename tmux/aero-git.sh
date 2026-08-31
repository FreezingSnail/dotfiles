#!/bin/sh

path=$1
branch=$(git -C "$path" symbolic-ref --quiet --short HEAD 2>/dev/null) || exit 0
[ -n "$branch" ] || exit 0

if git -C "$path" diff --name-only --diff-filter=U 2>/dev/null | grep -q .; then
  state=x
elif [ -n "$(git -C "$path" status --porcelain --untracked-files=normal 2>/dev/null)" ]; then
  state='!'
else
  state='+'
fi

printf ' %s %s' "$state" "$branch"
