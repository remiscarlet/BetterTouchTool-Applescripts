-- Will just display the current timestamp and duration of the song.
-- Eg, will just display something like "2:31/4:52" or whatever. 
-- Most effective if you set the BTT widget to update every <1 second.

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
