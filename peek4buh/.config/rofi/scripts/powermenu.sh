#!/usr/bin/bash

# Options
shutdown=''
reboot=''
lock=''
suspend=''
logout=''

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "Goodbye, ${USER}!" \
		-mesg "Uptime: $(uptime -p | sed -e 's/up //g')" \
		-theme $XDG_CONFIG_HOME/rofi/configs/powermenu.rasi
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	if [[ $1 == '--shutdown' ]]; then
		systemctl poweroff
	elif [[ $1 == '--reboot' ]]; then
		systemctl reboot
	elif [[ $1 == '--suspend' ]]; then
		mpc -q pause
		amixer set Master mute
		systemctl suspend
	elif [[ $1 == '--logout' ]]; then
		bspc quit
	fi
}

chosen="$(run_rofi)"
case ${chosen} in
    $shutdown) run_cmd --shutdown;;
    $reboot) run_cmd --reboot;;
    $lock)
	# TODO: do it :)
        ;;
    $suspend) run_cmd --suspend;;
    $logout) run_cmd --logout;;
esac
