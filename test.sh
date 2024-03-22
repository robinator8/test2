#!/bin/bash

# Placeholder Lorem Ipsum text
LOREM_IPSUM="Lorem ipsum dolor sit amet, consectetur adipiscing elit."

# Checkout main branch
git checkout main

# Loop to create files with names increasing in length by 32 characters, starting at 32, up to 128 characters.
for length in 32 64 96 128; do
  branch_name="files-${length}-chars"
  # Create and checkout new branch named according to file length
  git checkout -b "$branch_name"

  # Generate 100 files
  for i in $(seq -w 0 99); do
    seq=$(printf "%02d" $i) # Format sequence number with leading zeros
    base_pattern="file-${seq}"
    filename=$base_pattern
    while [ ${#filename} -lt $(($length-4)) ]; do
      filename+="$base_pattern"
    done
    # Trim to the desired length and add .txt extension
    filename="${filename:0:$(($length-4))}.txt"
    echo "$LOREM_IPSUM" > "$filename"
  done

  # Add, commit, and push the changes
  git add .
  git commit -m "Added 100 files with names of $length characters"
  git push -u origin "$branch_name"

  # Checkout main to prepare for the next iteration
  git checkout main
done

