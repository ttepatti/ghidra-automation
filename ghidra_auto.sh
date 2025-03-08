#!/bin/bash
# Still heavily a WIP
# By tim / hakstuff
# Overall goal is to enable easier firmware vulnerability analysis via Ghidra automation

# usage:
# ./ghidra_auto.sh [target elf]

# NOTE: Requires at least Ghidra 11.3_PUBLIC!
# (This is for the headless library loader)

GHIDRA_PATH="/path/to/ghidra"  # Update this path
BINARY_PATH="$1"

if [ -z "$BINARY_PATH" ]; then
    echo "Usage: $0 <binary>"
    exit 1
fi

BINARY_NAME=$(basename "$BINARY_PATH")
OUTPUT_DIR="ghidra_output/$BINARY_NAME"
HSPX_OUTPUT_DIR="HARUSPEX-$BINARY_NAME"
mkdir -p "$OUTPUT_DIR"

# Set up directories for scripts and libraries
SCRIPT_DIR="/path/to/ghidra/scripts" # Update this path
LIBRARY_DIR="/path/to/external/libraries" # Update this path

# Run Ghidra headless to extract decompiled pseudocode using 0xdea's Haruspex
$GHIDRA_PATH/support/analyzeHeadless "$OUTPUT_DIR" "ghidra_project" -import "$BINARY_PATH" -loader "ElfLoader" -loader-loadLibraries "true" -loader-libraryDestinationFolder "/libs" -librarySearchPaths "$LIBRARY_DIR" -scriptPath "$SCRIPT_DIR" -postScript "Haruspex.java" "$HSPX_OUTPUT_DIR" -deleteProject

echo "Analysis complete. Output stored in $OUTPUT_DIR"
