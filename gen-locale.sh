#!/bin/sh
# Usage: ./gen-translated-site.sh LANG
# Example: ./gen-translated-site.sh fr 
# Generates translated site using the .po files in _LANG.src/, then
# applies all overwrite files.

po2html -i _$1.src -t _en.src -o _$1.src 

# Replace any overwriten tags
if [ -d "_$1.overwrite" ]; then
    for ow_dir in $(find _$1.overwrite -type d -nowarn); do
        prefix="$(basename ${ow_dir%%.overwrite})"
        for ow_src in $(find "$ow_dir" -name "*.html"); do
            target="$(echo $ow_src | sed "s#overwrite#src#g")"
            python ReplaceTag.py $target $ow_src
        done
    done
fi
