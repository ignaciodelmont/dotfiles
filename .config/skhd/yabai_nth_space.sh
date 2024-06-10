#!/bin/zsh


function yabai_nth_space() {
    local display_id=$1
    local space_id=$2
    local space_to_move=$(yabai -m query --displays | jq ".[] | select(.id == $display_id) | .spaces[$space_id]")
    echo "Moving to space $space_to_move"
    yabai -m space --focus $space_to_move
}


yabai_nth_space "$@"
