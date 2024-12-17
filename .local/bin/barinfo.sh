#!/bin/sh

Workspace() {
	WORKSPACE=$(xprop -root 32c '\t$0' _NET_CURRENT_DESKTOP | cut -f 2)
	echo -n "$WORKSPACE"
}

Clock() {
	DATETIME=$(date "+%T")
	echo -n "$DATETIME"
}

Battery() {
	BATPERC=$(acpi --battery)
	echo -n "${BATPERC#*, }"
}

Brightness() {
	echo -n "$(brightnessctl get)"
}

ActiveWindow() {
	win=$(xdotool getwindowfocus getwindowname)
	len=${#win}
	max_len=20
	if [ "$len" -gt "$max_len" ]; then
		echo -n "${win:0:$max_len}..."
	else
		echo -n $win
	fi
}

Music() {
	artist=$(playerctl metadata xesam:artist)
	track=$(playerctl metadata xesam:title)
	
	if [ -z $artist ] && [ -z $track ];then
		echo -n ""
	else
		echo -n "$track - $artist"
	fi
}

while true; do
	#old: #927539
	echo -e "%{l}  $(Workspace)  $(ActiveWindow)" "%{c}$(Music)" "%{r}$(Battery); brightness: $(Brightness) %{F#e3e3e3}%{B#7ca8b5}  $(Clock)  %{B-}%{F-}"
	sleep 0.1s
done
