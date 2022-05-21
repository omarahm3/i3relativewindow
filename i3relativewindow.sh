#!/bin/bash

USAGE="i3relativewindow: I3wm utility script to show a floating window relatively to a focused workspace monitor based on percentage positions
  Arguments:
    instance: your window instance name
    window X: percentage of floating window X position
    window Y: percentage of floating window Y position
    width: your window width
    height: your window height
  Example:
    i3relativewindow quick-terminal 50 50 500 500 # This will toggle your 'quick-terminal' instance window on your focused workspace monitor and place it on the middle of your screen"

function check_args {
  if [[ $# -ne 5 ]]; then
    echo "$USAGE"
    exit 1
  fi
}

function main {
  INSTANCE=$1
  X_PERCENTAGE=$2
  Y_PERCENTAGE=$3
  WIN_WIDTH=$4
  WIN_HEIGHT=$5

  FOCUSED_WORKSPACE=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true)')
  FOCUSED_WORKSPACE_NAME=$(echo $FOCUSED_WORKSPACE | jq '.name')
  FOCUSED_WORKSPACE_MONITOR=$(echo $FOCUSED_WORKSPACE | jq '.output')

  focused_monitor=$(i3-msg -t get_outputs | jq ".[] | select(.name==$FOCUSED_WORKSPACE_MONITOR)")
  monitor_x=$(echo $focused_monitor | jq '.rect.x')
  monitor_y=$(echo $focused_monitor | jq '.rect.y')
  monitor_width=$(echo $focused_monitor | jq '.rect.width')
  monitor_height=$(echo $focused_monitor | jq '.rect.height')

  if [ "$monitor_x" == "0" ]; then
    win_x=$(($monitor_width * $X_PERCENTAGE/100))
  else
    win_x=$(($monitor_x * $X_PERCENTAGE/100 + $monitor_x))
  fi

  win_width=$(($WIN_WIDTH * $X_PERCENTAGE/100))
  win_x=$(($win_x - $win_width))

  if [ "$monitor_y" == "0" ]; then
    win_y=$(($monitor_height * $Y_PERCENTAGE/100))
    win_height=$(($WIN_HEIGHT * $Y_PERCENTAGE/100))
  else
    win_y=$(($monitor_y * $Y_PERCENTAGE/100 + $monitor_y))
    win_height=$(($WIN_HEIGHT * $Y_PERCENTAGE/100))
  fi
  
  win_y=$(($win_y - $win_height))
  
  i3-msg "[instance=\"$INSTANCE\"] scratchpad show; [instance=\"$INSTANCE\"] move absolute position $win_x $win_y"
}

check_args "$@"
main "$@"
