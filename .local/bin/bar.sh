#!/bin/sh

PID=$(pgrep lemonbar)
PID=${PID:-"NORUN"}
if [ "$PID" != "NORUN" ];then
	pkill $PID
fi

BG="#150904"
FONT="Terminus" 
RES=$(xdpyinfo | awk '/dimensions/{print $2}')
RES=(${RES//x/ })
YPOS=$((${RES[1]}-40))
echo $YPOS
barinfo.sh | lemonbar -g 1900x35+10+$YPOS -p -f $FONT -B $BG &
