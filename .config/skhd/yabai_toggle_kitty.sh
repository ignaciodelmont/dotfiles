#!/usr/bin/env bash

WINDOW_TITLE="floating-kitty"
WINDOW_ID=$(yabai -m query --windows | jq -e ".[] | select(.title==\"$WINDOW_TITLE\") | .id") || true

if [[ -z "$WINDOW_ID" ]]; then
    pgrep -x kitty >/dev/null &&
        kitty @ new-window --title "$WINDOW_TITLE" ||
            open -na /Applications/Kitty.app --args --title "$WINDOW_TITLE"

fi

WINDOW_ID=$(yabai -m query --windows | jq -e ".[] | select(.title==\"$WINDOW_TITLE\") | .id")
WINDOW_QUERY=$(yabai -m query --windows --window "$WINDOW_ID")
IS_MINIMIZED=$(echo "$WINDOW_QUERY" | jq '."is-minimized"')
IS_FLOATING=$(echo "$WINDOW_QUERY" | jq '."is-floating"')
CURRENT_SPACE=$(yabai -m query --spaces --space | jq '.index')


if [[ "${IS_MINIMIZED}" == "false" ]]; then
    yabai -m window "$WINDOW_ID" --minimize
else
    yabai -m window "$WINDOW_ID" --space "$CURRENT_SPACE"
    yabai -m window --focus "$WINDOW_ID"

    if [[ "${IS_FLOATING}" != "true" ]]; then
	yabai -m window "$WINDOW_ID" --toggle float
    fi

    yabai -m window "$WINDOW_ID" --space "$CURRENT_SPACE" --move abs:0:0 --grid "10:1:0:0:1:5"
fi

