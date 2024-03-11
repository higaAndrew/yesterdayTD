#!/bin/sh
echo -ne '\033c\033]0;Outpost Assault\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Outpost Assault.x86_64" "$@"
