#!/bin/bash

# Placeholder Lorem Ipsum text
LOREM_IPSUM="Lorem ipsum dolor sit amet, consectetur adipiscing elit."

# Function to generate a filename based on sequence number and desired length
generate_filename() {
  seq=$(printf "%02d" $1) # Ensure the sequence number is two digits
  base_pattern="file-${seq}"
  filename=$base_pattern
  desired_length=$2
  while [ ${#filename} -lt $desired_length ]; do
    filename+="$base_pattern"
  done
  # Trim the filename to the exact desired length, adding .txt extension
  echo "${filename:0:($desired_length-4)}.txt"
}

# Checkout main branch
git checkout main

# Filename length starts at 32 and increases by 32 each iteration, up to 128
for length in {32..128..32}; do
  branch_name="files-${length}-chars"
  # Create and checkout new branch named according to file length
  git checkout -b "$branch_name"

  # Generate 100 files
  for i in $(seq -w 0 99); do # Sequence numbers 00 to 99
    filename=$(generate_filename $i $length)
    echo "$LOREM_IPSUM" > "$filename"
  done

  # Add, commit, and push the changes
  git add .
  git commit -m "Added 100 files with names of $length characters"
  git push -u origin "$branch_name"

  # Checkout main to prepare for the next iteration
  git checkout main
done

