#!/bin/bash

# Create output folder if it doesn't exist
OUTPUT_FOLDER="logs"
mkdir -p "$OUTPUT_FOLDER"

# Find highest test## index in the logs folder and return it
LAST_INDEX=$(find "$OUTPUT_FOLDER" -maxdepth 1 -type f -name "test[0-9][0-9]*" \
  | sed -n 's#.*/test\([0-9][0-9]\).*#\1#p' \
  | sort -n | tail -n 1)

# Default to 0 if no previous files
if [[ -z "$LAST_INDEX" ]]; then
  NEW_INDEX=0
else
  NEW_INDEX=$((10#$LAST_INDEX + 1))  # Force decimal interpretation
fi

# Format as two digits
INDEX_PADDED=$(printf "%02d" "$NEW_INDEX")

# Timestamp and final log file name
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_FILE="$OUTPUT_FOLDER/test${INDEX_PADDED}_iperf3 $@_output_${TIMESTAMP}.log"

# Run iperf3 in background with real-time logging
echo "Running \"iperf3 $@\""
echo "Logging to: $OUTPUT_FILE"
echo "Running: iperf3 $@" > "$OUTPUT_FILE" # prepend the command to the log file
stdbuf -oL iperf3 "$@" 2>&1 | tee -a "$OUTPUT_FILE" & # append the output to the log file
IPERF_PID=$!

# Trap SIGINT/SIGTERM to stop iperf3 gracefully
trap "echo 'Stopping iperf3...'; kill -INT $IPERF_PID; wait $IPERF_PID; echo 'Results saved to $OUTPUT_FILE'; exit" INT TERM

# Wait for iperf3 to finish
wait $IPERF_PID
