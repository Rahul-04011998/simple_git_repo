#!/bin/bash

# Set the directory to watch
watch_dir="/root/shell_scripting-practice"

# Set the script to run when a new file is added
script_to_run="/root/shell_scripting-practice/cmdscript.sh"

# Create a temporary file to store the last modified time
tmp_file="/tmp/last_modified.txt"

# Initialize the last modified time to 0
echo 0 > "$tmp_file"

# Infinite loop to watch the directory
while true; do
    # Get the current modified time of the directory
    current_modified=$(stat -c %Y "$watch_dir")

    # Read the last modified time from the temporary file
    last_modified=$(cat "$tmp_file")

    # Check if the directory has been modified since the last check
    if [ "$current_modified" -gt "$last_modified" ]; then
        # Get the list of new files added since the last check
        new_files=$(find "$watch_dir" -newer "$tmp_file" -type f)

        # Run the script for each new file
        for file in $new_files; do
            "$script_to_run" "$file"
        done

        # Update the last modified time in the temporary file
        echo "$current_modified" > "$tmp_file"
    fi

    # Wait for 1 second before checking again
    sleep 1
done
