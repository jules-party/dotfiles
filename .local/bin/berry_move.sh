#!/bin/sh

eval $(xdotool getmouselocation --shell)
SX=$X
SY=$Y

while [ ! $1 ]; do
    eval $(xdotool getmouselocation --shell)
    berryc window_move $(echo "$X - $SX" | bc) $(echo "$Y - $SY" | bc)
    SX=$X
    SY=$Y
done

pkill -f $0
