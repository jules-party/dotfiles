#!/bin/sh

feh --bg-scale ${HOME}/.local/wallpapers/room.jpg &
xrdb .Xresources &	
bar.sh &
exec cwm	
