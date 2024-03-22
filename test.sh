#!/bin/bash

# Placeholder Lorem Ipsum text
LOREM_IPSUM="Lorem ipsum dolor sit amet, consectetur adipiscing elit."

# Checkout main branch
git checkout main

# Loop to create a varying number of files (95 to 100)
for num_files in {95..100}; do
  branch_name="files-${num_files}"
  # Create and checkout new branch named according to the number of files
  git checkout -b "$branch_name"

  # Generate files according to the specified count
  for i in $(seq 0 $(($num_files - 1))); do
    # Format sequence number with leading zeros, avoiding octal interpretation
    seq=$(printf "%02d" $i)
    base_pattern="file-${seq}"
    filename=$base_pattern
    length=80 # Set filename length to 80 characters
    while [ ${#filename} -lt $(($length-4)) ]; do
      filename+="$base_pattern"
    done
    # Trim to the desired length and add .txt extension
    filename="${filename:0:$(($length-4))}.txt"
    echo "$LOREM_IPSUM" > "$filename"
  done

  # Add, commit, and push the changes
  git add .
  git commit -m "Added $num_files files with names of 80 characters"
  git push -u origin "$branch_name"

  # Checkout main to prepare for the next iteration
  git checkout main
done

