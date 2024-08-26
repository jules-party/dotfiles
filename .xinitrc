#!/bin/sh

feh --bg-scale ${HOME}/.local/wallpapers/what-hell-looks-like-history.jpeg &
xrdb .Xresources &	
bar.sh &
exec cwm	
