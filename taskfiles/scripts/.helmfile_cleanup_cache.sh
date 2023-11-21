#!/bin/bash

set -eu

# File to store the last execution timestamp
TIMESTAMP_FILE="$HOME/.last_helmfile_cleanup"

# Function to run helmfile cache cleanup
run_cleanup() {
    echo "Running helmfile cache cleanup..."
    helmfile cache cleanup
    # Update the last run timestamp
    date +%s > "$TIMESTAMP_FILE"
}

# Check if the timestamp file exists
if [ -f "$TIMESTAMP_FILE" ]; then
    # Get the current and last run timestamps
    CURRENT_TIME=$(date +%s)
    LAST_RUN=$(cat "$TIMESTAMP_FILE")

    # Calculate the difference in minutes
    DIFF=$(( (CURRENT_TIME - LAST_RUN) / 60 ))

    if [ $DIFF -ge 5 ]; then
        # It's been more than 5 minutes
        run_cleanup
    else
        echo "Cache cleanup was run less than 5 minutes ago."
    fi
else
    run_cleanup
fi
