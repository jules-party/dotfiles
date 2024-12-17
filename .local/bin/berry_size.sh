#!/bin/sh

eval $(xdotool getmouselocation --shell)
SX=$X
SY=$Y

# window info
wininfo=$(xdotool getwindowfocus getwindowgeometry)
wininfoarr=(${wininfo//$'\n'/})

WID=${wininfoarr[1]}
POS=${wininfoarr[3]}
GEO=${wininfoarr[7]}

GEO=(${GEO//x/ })
POS=(${POS//,/ })

while [ ! $1 ]; do
	xdotool mousemove $((${GEO[0]}-30)) $((${GEO[1]}-30))
	eval $(xdotool getmouselocation --shell)
	berryc window_resize $(echo "$X - $SX" | bc) $(echo "$Y - $SY" | bc)
	SX=$X
	SY=$Y
done

pkill -f $0
