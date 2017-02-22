tell application "iTunes"
	set shuffle_mode to shuffle enabled
	set the shuffle enabled to not shuffle_mode
	if not shuffle_mode then
		return "🔀"
	else
		return "❗️🔀"
	end if
end tell