#!/bin/sh

PID=$(pgrep lemonbar)
PID=${PID:-"NORUN"}
if [ "$PID" != "NORUN" ];then
	kill $PID
fi

#BG="#150904"
BG="#c5c7b2"
FG="#001003"
FONT="Terminus" 
RES=$(xdpyinfo | awk '/dimensions/{print $2}')
RES=(${RES//x/ })
YPOS=$((${RES[1]}-40))
echo $YPOS
barinfo.sh | lemonbar -g 1900x35+10+$YPOS -p -f $FONT -B $BG -F $FG &
