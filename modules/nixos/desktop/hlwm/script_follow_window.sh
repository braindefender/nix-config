#!/usr/bin/env bash

# get the focus window position and geometry and calculate the mouse location
_mouse_follow_() {
    while read -ra line ; do
        [ "${line[0]}" = "Position:" ]  && POS_Y="${line[1]#*,}" POS_X="${line[1]%,*}"
        [ "${line[0]}" = "Geometry:" ]  && WIDTH="${line[1]%x*}" HEIGHT="${line[1]#*x}"
    done < <(xdotool getwindowgeometry $(xdotool getwindowfocus) 2> /dev/null)

    X=$((POS_X + (WIDTH/2)))
    Y=$((POS_Y + (HEIGHT/2)))

    xdotool mousemove "$X" "$Y" &> /dev/null
}

_mouse_follow_
