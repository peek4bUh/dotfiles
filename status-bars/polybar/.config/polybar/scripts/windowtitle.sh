apps=("Mozilla Firefox" "Obsidian")

while true; do
	title=$(xdotool getactivewindow getwindowname 2>/dev/null)

	for app in ${apps[@]}; do
		if echo "$title" | grep -q "$app"; then
			title="$app"
		fi
	done

	if [ -z "$title" ]; then
		echo "Desktop"
	else
		echo "$title"
	fi
done
