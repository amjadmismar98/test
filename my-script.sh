#!/bin/bash

git tag | awk -F '-' '{print $1}' | sort -u | while read -r prefix; do
    highest_tag=$(git tag --list "$prefix-*" | sort -V | tail -n1)
    echo "$highest_tag"
done >> highest_tags.txt
