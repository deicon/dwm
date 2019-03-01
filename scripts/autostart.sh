#!/bin/bash
compton --config ~/.config/compton/compton.conf &
# 0: +*HDMI-2 3440/798x1440/335+0+0  HDMI-2
# 1: +HDMI-1-0 1920/510x1080/290+3440+0  HDMI-1-0
sleep 5
# activate second window
#xrandr --output HDMI-1-0 --auto --right-of HDMI-2 &
# setting the last background images
nitrogen --restore&

gnome-terminal&

while (true); do
   ~/.dwm/update.sh
   sleep 10s
done
