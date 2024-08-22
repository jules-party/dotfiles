#!/bin/sh

# top, bottom, left, right
GAPS=(40 40 40 40)
# gap between windows
BGAP=10

# screen info
screenstr=$(xdpyinfo | awk '/dimensions/{print $2}')
# 0: x, 1, y
RES=(${screenstr//x/ })

# window info
wininfo=$(xdotool getwindowfocus getwindowgeometry)
wininfoarr=(${wininfo//$'\n'/})

WID=${wininfoarr[1]}
POS=${wininfoarr[3]}
GEO=${wininfoarr[7]}

# See if argument is valid
args=('up' 'down' 'right' 'left' 'center')
if [[ ! " ${args[*]} " == *" $1 "* ]];then
	printf "argument, $1, not valid!"
	exit 1
fi

center() {
	XHALF=$((${RES[0]}/2))
	YHALF=$((${RES[1]}/2))

	GEO=(${GEO//x/ })
	NX=$((${XHALF}-(${GEO[0]}/2)))
	NY=$((${YHALF}-(${GEO[1]}/2)))

	wmctrl -ir $WID -e "0,$NX,$NY,${GEO[0]},${GEO[1]}"
	xdotool mousemove $((${NX}+20)) $((${NY}+20))
}

up() {
	GEO=(${GEO//x/ })
	POS=(${POS//,/ })
	NH=$(((${RES[1]}/2)-(${GAPS[0]}+${BGAP})))
	NY=${GAPS[1]}

	wmctrl -ir $WID -e "0,${POS[0]},$NY,${GEO[0]},$NH"
	xdotool mousemove $((${POS[0]}+20)) $((${NY}+20))
}

down() {
	GEO=(${GEO//x/ })
	POS=(${POS//,/ })
	NH=$(((${RES[1]}/2)-(${BGAP}+${GAPS[1]})))
	NY=$((${RES[1]}-(${GAPS[1]}+${NH})))

	wmctrl -ir $WID -e "0,${POS[0]},$NY,${GEO[0]},$NH"
	xdotool mousemove $((${POS[0]}+20)) $((${NY}+20))
}

left() {
	XHALF=$((${RES[0]}/2))

	NW=$(((${XHALF}-${GAPS[2]})-${BGAP}))
	NH=$((${RES[1]}-(${GAPS[0]}+${GAPS[1]})))

	NX=${GAPS[2]}
	NY=${GAPS[0]}

	# g,x,y,w,h
	# g is for gravity, not needed
	wmctrl -ir $WID -e "0,$NX,$NY,$NW,$NH"
	xdotool mousemove $((${NX}+20)) $((${NY}+20))
}

right() {
	# Get half of the width of the screen res
	XHALF=$((${RES[0]}/2))

	# Get New width/height for window
	NW=$(((${XHALF}-${GAPS[3]})-${BGAP}))
	NH=$((${RES[1]}-(${GAPS[0]}+${GAPS[1]})))

	# Get new X/Y
	NX=$(((${RES[0]}-$NW)-${GAPS[3]}))
	NY=${GAPS[0]}

	# g,x,y,w,h
	# g is for gravity, not needed
	wmctrl -ir $WID -e "0,$NX,$NY,$NW,$NH"
	xdotool mousemove $((${NX}+20)) $((${NY}+20))
}

case $1 in
	'up') up;;
	'down') down;;
	'left') left;;
	'right') right;;
	'center') center;;
esac

