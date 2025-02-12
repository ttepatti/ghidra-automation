#!/bin/bash
# by Tim / hakstuff

# Glorified one-liner to comb through a filesystem for all shared libraries and copy them to a folder
# Useful for resolving Ghidra dependencies or performing bulk analysis

find . -exec file -F '' {} \; | grep -i elf | grep -i "shared object" | awk '{print $1}' | xargs -i cp {} shared-libraries/
