#!/bin/sh

background="$1"
text="$2"

mako \
--default-timeout 5000 \
--background-color "$background" \
--text-color "$text" \
--border-radius 3px \
&

