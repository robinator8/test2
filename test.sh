#!/bin/bash

# Placeholder Lorem Ipsum text
LOREM_IPSUM="Lorem ipsum dolor sit amet, consectetur adipiscing elit."

# Function to generate a filename based on sequence number
generate_filename() {
  seq=$(printf "%02d" $1) # Ensure the sequence number is two digits
  pattern="file-${seq}"
  while [ ${#pattern} -lt 28 ]; do # Ensure the total length is up to 28 characters
    pattern+="${seq}"
  done
  echo "${pattern:0:28}.txt" # Trim and add .txt extension to maintain 32 chars overall
}

# Checkout main branch
git checkout main

# Loop from 10 to 100, skipping by 10
for x in $(seq 10 10 100); do
  branch_name="${x}-files"
  # Create and checkout new branch named x-files
  git checkout -b "$branch_name"

  # Generate x files
  for ((i=1; i<=x; i++)); do
    filename=$(generate_filename $i)
    echo "$LOREM_IPSUM" > "$filename"
  done

  # Add, commit, and push the changes
  git add .
  git commit -m "Added $x files with patterned names"
  git push -u origin "$branch_name"

  # Checkout main to prepare for the next iteration
  git checkout main
done
