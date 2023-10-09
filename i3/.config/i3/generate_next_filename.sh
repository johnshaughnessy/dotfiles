#!/bin/bash

# Directory to scan
dir="/home/john/src/blog/blog/static/image/the_book_of_why"

# Get the highest numbered file
highest_number=$(find "$dir" -type f -name 'screenshot_*.png' | grep -oP '(?<=screenshot_)\d+(?=.png)' | sort -n | tail -1)

# Increment the number for the next filename
next_number=$(printf "%03d" $((highest_number + 1)))

# Generate the next filename
next_filename="screenshot_$next_number.png"

echo "$dir/$next_filename"
