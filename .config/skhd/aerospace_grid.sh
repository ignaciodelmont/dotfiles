#!/usr/bin/env bash
# Arrange the tiled windows of the focused AeroSpace workspace into a near-square grid.
# Columns = ceil(sqrt(n)); leftover windows go to the rightmost columns, so the
# first window gets the most space (e.g. 3 windows -> big left + 2 stacked right).

set -u

focused=$(aerospace list-windows --focused --format '%{window-id}' 2>/dev/null) || exit 0
n=$(aerospace list-windows --workspace focused --format '%{window-layout}' | grep -c '_tiles\|_accordion')
[ "$n" -lt 2 ] && exit 0

# Start from a single horizontal row
aerospace flatten-workspace-tree
aerospace layout --window-id "$focused" h_tiles 2>/dev/null

# Collect tiled window ids left-to-right (DFS order)
ids=()
for ((i = 0; i < n; i++)); do
  aerospace focus --dfs-index "$i" 2>/dev/null || break
  ids+=("$(aerospace list-windows --focused --format '%{window-id}')")
done
n=${#ids[@]}

cols=$(awk -v n="$n" 'BEGIN { c = int(sqrt(n)); if (c * c < n) c++; print c }')
base=$((n / cols))
extra=$((n % cols))

idx=0
for ((c = 0; c < cols; c++)); do
  rows=$base
  [ "$c" -ge $((cols - extra)) ] && rows=$((rows + 1))
  if [ "$rows" -ge 2 ]; then
    # First two windows of the column form a vertical container...
    aerospace join-with --window-id "${ids[idx]}" right
    # ...and the rest are moved into it from the right
    for ((r = 2; r < rows; r++)); do
      aerospace move --window-id "${ids[idx + r]}" left
    done
  fi
  idx=$((idx + rows))
done

aerospace balance-sizes
aerospace focus --window-id "$focused"
