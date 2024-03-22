#!/bin/bash

# Placeholder Lorem Ipsum text
LOREM_IPSUM="Lorem ipsum dolor sit amet, consectetur adipiscing elit."

# Function to generate a filename based on sequence number
generate_filename() {
  seq=$1
  # Create the repeating sequence pattern
  pattern=$(printf '%s-' file; printf "%.s$seq" {1..32})
  # Truncate to 32 characters and add .txt extension
  echo "${pattern:0:28}.txt"
}

# Assert the filename length is 32 characters
assert_filename_length() {
  filename=$1
  if [ ${#filename} -ne 32 ]; then
    echo "Error: Filename $filename is not 32 characters long."
    exit 1
  fi
}

# Checkout main branch
git checkout main

# Loop from 10 to 100, skipping by 10
for x in {10..100..10}; do
  # Create and checkout new branch named x-files
  git checkout -b ${x}-files

  # Generate x files
  for ((i=1; i<=x; i++)); do
    filename=$(generate_filename $i)
    assert_filename_length "$filename"
    echo "$LOREM_IPSUM" > "$filename"
  done

  # Add, commit, and push the changes
  git add .
  git commit -m "Added $x files with patterned names"
  git push -u origin ${x}-files

  # Checkout main to prepare for the next iteration
  git checkout main
done

