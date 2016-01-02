#!/bin/bash

setxkbmap de
xinput set-button-map 11 3 2 1 4 5 6 7 8 9 10 11 12 13
xrandr --newmode "1680x1050_60.00" 146.25 1680 1784 1960 2240 1050 1053 1059 1089 -hsync +vsync
xrandr --addmode DVI-I-1 1680x1050_60.00
xrandr --output DVI-I-1 --mode 1680x1050_60.00 --left-of DVI-I-2
xrandr --output DVI-I-1 --primary
numlockx on
#xflux -l 14 -g 52 -k 2700
exec i3 #-V > ~/.i3/log/$(date)
