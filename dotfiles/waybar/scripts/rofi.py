#!/usr/bin/env python

import json

# Define the module text, icon, and tooltip
out_data = {
    "text": "Launcher",
    "class": "rofi",
    "tooltip": "Open Rofi",
}

# Output the module as JSON
print(json.dumps(out_data))
