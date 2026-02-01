#!/bin/sh
printf '\033c\033]0;%s\a' Global Game Jam 2026
base_path="$(dirname "$(realpath "$0")")"
"$base_path/AlphaVersion.x86_64" "$@"
