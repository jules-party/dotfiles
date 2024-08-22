#!/bin/sh

Clock() {
	DATETIME=$(date "+%T")
	printf "$DATETIME"
}

Battery() {
	BATPERC=$(acpi --battery | cut -d, -f2)
	printf "$BATPERC"
}
