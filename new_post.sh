#!/bin/bash

# Check if the correct number of arguments are passed
if [ "$#" -ne 2 ]; then
    echo "You must enter exactly 3 arguments: title, category"
    exit 1
fi

# Assign arguments to variables
LAYOUT=post
TITLE=$1
CATEGORY1=$1
# CATEGORY2=$4

# Generate filename based on title and current date
FILENAME="$(date +%Y-%m-%d)-$(echo $TITLE | tr ' ' '-')".md

# Get current date
DATE=$(date +"%Y-%m-%d %H:%M:%S %z")

# Create a new markdown file
cat << EOF > "_posts/$FILENAME"
---
layout: $LAYOUT
title:  "$TITLE"
date:   $DATE
categories: $CATEGORY1
---

### Setting up rails app with github primer
EOF

echo "Markdown file '$FILENAME' created successfully."
