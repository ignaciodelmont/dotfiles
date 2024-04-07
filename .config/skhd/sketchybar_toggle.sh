#!/bin/bash

# fix this!

current_value=$(sketchybar --query bar | jq -r .hidden)
echo $current_value
if [ "$current_value" = "on" ]; then
    sketchybar --config bar hidden="off"
    current_height=$(sketchybar --query bar | jq -r .height)
    yabai -m config external_bar all:$current_height:0
else
    sketchybar --config bar hidden="on"
    yabai -m config external_bar all:0:0
fi
