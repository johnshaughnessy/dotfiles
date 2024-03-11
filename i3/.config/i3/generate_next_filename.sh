#!/bin/bash

# Directory to scan
#dir="/home/john/media/image/screenshots/"
dir="/home/john/src/blog/blog/static/image/memory_cache_march_update/"

# Get the highest numbered file, and ensure the number is treated as decimal by stripping leading zeros
highest_number=$(find "$dir" -type f -name 'screenshot_*.png' | grep -oP '(?<=screenshot_)\d+(?=.png)' | sort -n | tail -1 | sed 's/^0*//')

# If no files were found, start at 1
if [ -z "$highest_number" ]; then
    highest_number=0
fi

# Increment the number for the next filename
next_number=$(printf "%03d" $((10#$highest_number + 1)))

# Generate the next filename
next_filename="screenshot_$next_number.png"

echo "$dir/$next_filename"
