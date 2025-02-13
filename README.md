# ghidra-automation
Proof of concept scripts for automating Ghidra analysis. These scripts are mainly for testing functionality which can later be included in my [elf-analyzer project](https://github.com/ttepatti/elf-analyzer).

## ghidra_auto.sh

This script is for testing a slightly more automated Ghidra workflow for analyzing ELFs. It takes advantage of the Ghidra headless analyzer and 0xdea's Haruspex to automatically analyze and dump the pseudocode of a targeted ELF binary.

## so_finder.sh

This script is a glorified one-liner to comb through a filesystem for all shared libraries and copy them to a folder. It's useful for building a database of all shared libraries on a given embedded system, specifically when trying to give Ghidra a single location to search for shared libraries!
