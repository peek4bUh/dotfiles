#!/usr/bin/bash
#
# Author: Angel @peek4bUh Andrade
# Filename: rofi/scripts/screenshot.sh
# Repository: https://github.com/peek4bUh/dotfiles
# Source: https://github.com/adi1090x/rofi/blob/master/files/applets/bin/screenshot.sh
#


theme="$XDG_CONFIG_HOME/rofi/configs/screenshot.rasi"
mesg="DIR: \$XDG_PICTURES_DIR/screenshots"

# Options
option_1=" Capture Desktop"
option_2=" Capture Area"
option_3=" Capture Window"
option_4=" Capture in 5s"

rofi_cmd() {
	rofi -theme-str "window {width: 400px;}" \
		-theme-str "listview {columns: 1; lines: 5;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "Screenshot" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4" | rofi_cmd
}

# Screenshot
time=$(date +%Y-%m-%d-%H-%M-%S)
dir="$(xdg-user-dir PICTURES)screenshots"
file="screenshot_${time}.png"

[[ ! -d "$dir" ]] && mkdir -p "$dir"

# notify and view screenshot
notify_view() {
	notify_cmd_shot='dunstify -u low --replace=699'
	${notify_cmd_shot} "Copied to clipboard."
	feh "$dir/$file"
	if [[ -e "$dir/$file" ]]; then
		${notify_cmd_shot} "Screenshot Saved."
	else
		${notify_cmd_shot} "Screenshot Deleted."
	fi
}

# Copy screenshot to clipboard
copy_shot () {
	tee "$file" | xclip -selection clipboard -t image/png
}

countdown () {
	for sec in `seq $1 -1 1`; do
		dunstify -t 1000 --replace=699 "Taking shot in : $sec"
		sleep 1
	done
}

shotnow () {
	cd ${dir} && sleep 0.5 && maim -u -f png | copy_shot
	notify_view
}

shot () {
	countdown $1
	sleep 1 && cd ${dir} && maim -u -f png | copy_shot
	notify_view
}

shotwin () {
	cd ${dir} && maim -u -f png -i `xdotool getactivewindow` | copy_shot
	notify_view
}

shotarea () {
	cd ${dir} && maim -u -f png -s -b 2 -c 0.35,0.55,0.85,0.25 -l | copy_shot
	notify_view
}

chosen="$(run_rofi)"
case ${chosen} in
    $option_1) shotnow;;
    $option_2) shotarea;;
    $option_3) shotwin;;
    $option_4) shot 5;;
esac
