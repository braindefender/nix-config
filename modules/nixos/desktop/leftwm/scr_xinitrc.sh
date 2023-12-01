#!/usr/bin/env bash

# Apply high refresh rate via XRandR
xrandr --output HDMI1 --mode 3440x1440 --rate 99.98

# Run Figma Agent
if [ -x "$(command -v figma-agent)" ]; then
    figma-agent &
fi

# Enable NumLock
if [ -x "$(command -v numlockx)" ]; then
    numlockx &
fi

# Activate Universal Layout
setxkbmap -layout universalLayoutOrtho

# Launch LeftWM via DBus. Must be the last.
exec dbus-launch leftwm
