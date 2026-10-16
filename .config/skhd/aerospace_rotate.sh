#!/usr/bin/env bash
# Rotate the tiled windows of the focused AeroSpace workspace by one slot (DFS order),
# keeping the layout shape. Usage: aerospace_rotate.sh [forward|backward]
#   forward:  every window moves to the next slot, the last one wraps to the first
#   backward: every window moves to the previous slot, the first one wraps to the last

set -u

dir=${1:-forward}
focused=$(aerospace list-windows --focused --format '%{window-id}' 2>/dev/null) || exit 0
n=$(aerospace list-windows --workspace focused --format '%{window-layout}' | grep -c '_tiles\|_accordion')
[ "$n" -lt 2 ] && exit 0

if [ "$dir" = backward ]; then
  start=0; step=dfs-next
else
  start=$((n - 1)); step=dfs-prev
fi

# Walk one window across every slot; the others shift by one along the way
aerospace focus --dfs-index "$start"
moving=$(aerospace list-windows --focused --format '%{window-id}')
for ((i = 1; i < n; i++)); do
  aerospace swap --window-id "$moving" "$step"
done

aerospace focus --window-id "$focused"
