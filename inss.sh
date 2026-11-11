#!/bin/bash


read -r -p "Source (input) file: " src
read -r -p "Destination (output) device: " dst

if [ ! -e "$src" ]; then
    echo "ERROR: '$src' does not exist." >&2
    exit 1
fi

echo "This will overwrite '$dst' with the contents of '$src'."
read -r -p "Continue? (Y/n): " confirm

if [[ "${confirm,,}" == "yes" || "${confirm,,}" == "y" ]]; then
    echo "Continuing..."
else
    echo "Cancelled."
    exit 0
fi
if dd if="$src" of="$dst" bs=4M status=progress conv=fsync; then
    sync
    echo "Devices flashed succesfully!"
else
    echo "ERROR: dd failed with exit code $?." >&2
    exit 1
fi

