#!/bin/sh

feh --bg-scale ${HOME}/.local/wallpapers/almond.jpg &
xrdb .Xresources &	
#sxhkd &
#exec berry
bar.sh &
exec cwm
