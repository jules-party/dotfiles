#!/bin/sh

Clock() {
	DATETIME=$(date "+%T")
	echo -n "$DATETIME"
}

Battery() {
	BATPERC=$(acpi --battery)
	echo -n "${BATPERC#*, }"
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

while true; do
	echo -e "%{l}  $(ActiveWindow)" "%{r}$(Battery) %{B#af875f}  $(Clock)  %{B-}"
	sleep 0.1s
done
