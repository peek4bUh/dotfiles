#!/usr/bin/bash
#
#  Author: Angel @peek4bUh Andrade
#  Filename: rofi/scripts/powermenu.sh
#  Repository: https://github.com/peek4bUh/dotfiles
#  Source: https://github.com/adi1090x/rofi/blob/master/files/powermenu/type-4/powermenu.sh
#


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

chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
	systemctl poweroff;;
    $reboot)
	systemctl reboot;;
    $lock)
	# TODO: do it :)
	    ;;
    $suspend)
	systemctl suspend;;
    $logout)
	bspc quit;;
esac
