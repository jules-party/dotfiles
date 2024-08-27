#!/bin/sh

# top, bottom, left, right
GAPS=(40 50 40 40)
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

GEO=(${GEO//x/ })
POS=(${POS//,/ })


# See if argument is valid
args=('up' 'down' 'left' 'right' 'center' 'maximize' 'exleft' 'exright' 'exup' 'exdown' 'uxleft' 'uxright' 'uxup' 'uxdown')
if [[ ! " ${args[*]} " == *" $1 "* ]];then
	printf "argument, $1, not valid!"
	exit 1
fi

# don't continue if lemobar is the selected window
WIN=$(xdotool getwindowfocus getwindowname)
WIN=${WIN,,}
if [ "$WIN" = "bar" ];then
	printf "selected window is 'bar'!"
	exit 1
fi

uxdown() {
	NH=$((${GEO[1]}-20))
	NY=$((${POS[1]}+20))

	wmctrl -ir $WID -e "0,${POS[0]},$NY,${GEO[0]},$NH"
	xdotool mousemove $((${POS[0]}+(${GEO[0]}/2))) $((${NY}+(${NH}/2)))
}

uxup() {
	NH=$((${GEO[1]}-20))

	wmctrl -ir $WID -e "0,${POS[0]},${POS[1]},${GEO[0]},$NH"
	xdotool mousemove $((${POS[0]}+(${GEO[0]}/2))) $((${POS[1]}+(${NH}/2)))
}

uxleft() {
	NW=$((${GEO[0]}-20))

	wmctrl -ir $WID -e "0,${POS[0]},${POS[1]},$NW,${GEO[1]}"
	xdotool mousemove $((${POS[0]}+(${NW}/2))) $((${POS[1]}+(${GEO[1]}/2)))
}

uxright() {
	NW=$((${GEO[0]}-20))
	NX=$((${POS[0]}+20))

	wmctrl -ir $WID -e "0,$NX,${POS[1]},$NW,${GEO[1]}"
	xdotool mousemove $((${NX}+(${NW}/2))) $((${POS[1]}+(${GEO[1]}/2)))
}

exup() {
	NH=$((${GEO[1]}+20))
	NY=$((${POS[1]}-20))

	wmctrl -ir $WID -e "0,${POS[0]},$NY,${GEO[0]},$NH"
	xdotool mousemove $((${POS[0]}+(${GEO[0]}/2))) $((${NY}+(${NH}/2)))
}

exdown() {
	NH=$((${GEO[1]}+20))

	wmctrl -ir $WID -e "0,${POS[0]},${POS[1]},${GEO[0]},$NH"
	xdotool mousemove $((${POS[0]}+(${GEO[0]}/2))) $((${POS[1]}+(${NH}/2)))
}

exright() {
	NW=$((${GEO[0]}+20))

	wmctrl -ir $WID -e "0,${POS[0]},${POS[1]},$NW,${GEO[1]}"
	xdotool mousemove $((${POS[0]}+(${NW}/2))) $((${POS[1]}+(${GEO[1]}/2)))
}

exleft() {
	NW=$((${GEO[0]}+20))
	NX=$((${POS[0]}-20))

	wmctrl -ir $WID -e "0,$NX,${POS[1]},$NW,${GEO[1]}"
	xdotool mousemove $((${NX}+(${NW}/2))) $((${POS[1]}+(${GEO[1]}/2)))
}

maximize() {
	XHALF=$((${RES[0]}/2))
	YHALF=$((${RES[1]}/2))

	NW=$((${RES[0]}-(${GAPS[2]}+${GAPS[3]})))
	NH=$((${RES[1]}-(${GAPS[0]}+${GAPS[1]})))

	NX=$((${XHALF}-(${NW}/2)))
	NY=$((${YHALF}-(${NH}/2)))

	wmctrl -ir $WID -e "0,${GAPS[0]},${GAPS[2]},$NW,$NH"
	xdotool mousemove $((${NX}+(${NW}/2))) $((${NY}+(${NH}/2)))
}

center() {
	XHALF=$((${RES[0]}/2))
	YHALF=$((${RES[1]}/2))

	NX=$((${XHALF}-(${GEO[0]}/2)))
	NY=$((${YHALF}-(${GEO[1]}/2)))

	wmctrl -ir $WID -e "0,$NX,$NY,${GEO[0]},${GEO[1]}"
	xdotool mousemove $((${NX}+(${GEO[0]}/2))) $((${NY}+(${GEO[1]}/2)))
}

up() {
	NH=$(((${RES[1]}/2)-(${GAPS[0]}+${BGAP})))
	NY=${GAPS[1]}

	wmctrl -ir $WID -e "0,${POS[0]},$NY,${GEO[0]},$NH"
	xdotool mousemove $((${POS[0]}+(${GEO[0]}/2))) $((${NY}+(${GEO[1]}/2)))
}

down() {
	NH=$(((${RES[1]}/2)-(${BGAP}+${GAPS[1]})))
	NY=$((${RES[1]}-(${GAPS[1]}+${NH})))

	wmctrl -ir $WID -e "0,${POS[0]},$NY,${GEO[0]},$NH"
	xdotool mousemove $((${POS[0]}+(${GEO[0]}/2))) $((${NY}+(${GEO[1]}/2)))
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
	xdotool mousemove $((${NX}+(${GEO[0]}/2))) $((${NY}+(${GEO[1]}/2)))
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
	xdotool mousemove $((${NX}+(${GEO[0]}/2))) $((${NY}+(${GEO[1]}/2)))
}

case $1 in
	'up')       up;;
	'down')     down;;
	'left')     left;;
	'right')    right;;
	'center')   center;;
	'maximize') maximize;;
	'exleft')   exleft;;
	'exright')  exright;;
	'exup')     exup;;
	'exdown')   exdown;;
	'uxleft')   uxleft;;
	'uxright')  uxright;;
	'uxup')     uxup;;
	'uxdown')   uxdown;;
esac

