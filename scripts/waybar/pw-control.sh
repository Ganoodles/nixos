#!/bin/bash

# Check for required arguments
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <percentage> <direction>"
    exit 1
fi

# Get the arguments
percent=$1
change=$2

# Calculate the volume change
if [ "$change" == "up" ]; then
    volume_change="${percent}%+"
elif [ "$change" == "down" ]; then
    volume_change="${percent}%-"
else
    echo "Invalid direction: $change"
    exit 1
fi

# Set the new volume level
wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ "$volume_change"

