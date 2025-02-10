#!/bin/bash
# still heavily a WIP
# overall goal is to enable easier firmware vulnerability analysis via Ghidra automation

# usage:
# ./ghidra_auto.sh [target elf]

GHIDRA_PATH="/path/to/ghidra"  # Update this path
BINARY_PATH="$1"

if [ -z "$BINARY_PATH" ]; then
    echo "Usage: $0 <binary>"
    exit 1
fi

BINARY_NAME=$(basename "$BINARY_PATH")
OUTPUT_DIR="ghidra_output/$BINARY_NAME"
mkdir -p "$OUTPUT_DIR"

# Step 1: Run Ghidra headless to find dangerous functions
$GHIDRA_PATH/support/analyzeHeadless "$OUTPUT_DIR" "ghidra_project" -import "$BINARY_PATH" -postScript "find_dangerous_functions.py" -deleteProject

# Step 2: Run Ghidra headless to extract decompiled pseudocode using 0xdea's Haruspex
$GHIDRA_PATH/support/analyzeHeadless "$OUTPUT_DIR" "ghidra_project" -import "$BINARY_PATH" -postScript "Haruspex.java" -deleteProject

echo "Analysis complete. Output stored in $OUTPUT_DIR"
