#!/bin/bash

# Function to get the highest tag for a given prefix
get_highest_tag() {
    git tag --list "$1-*" | sort -V | tail -n1
}

# Clear the existing .env file and set the header
echo "# Environment variables" > .env

# Initialize an array to track processed prefixes
processed=()

# Populate .env file with prefixes and their highest tags
git tag | awk -F '-' '{print $1}' | sort -u | while read -r prefix; do
    # Check if the prefix is already processed
    if [[ ! " ${processed[@]} " =~ " $prefix " ]]; then
        highest_tag=$(get_highest_tag "$prefix")
        echo "$prefix=$highest_tag" >> .env
        processed+=("$prefix")
    fi
done
