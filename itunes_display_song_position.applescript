on convertToTimestamp(t)
	set h to t div 3600 as integer
	set m to t div 60 mod 60 as integer
	set s to t mod 60 as integer
	if h is greater than 0 then
		return (h as string) & ":" & (m as string) & ":" & (s as string)
	else
		return (m as string) & ":" & (s as string)
	end if
end convertToTimestamp

tell application "iTunes"
	set trackInfo to current track
	set rtnString to my convertToTimestamp(player position) & "/"
	set rtnString to rtnString & my convertToTimestamp(duration of trackInfo)
	return rtnString
end tell
