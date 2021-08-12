-- Will just display the current timestamp and duration of the song.
-- Eg, will just display something like "2:31/4:52" or whatever. 
-- Most effective if you set the BTT widget to update every <1 second.

on convertToTimestamp(t)
	set h to t div 3600 as integer as string
	set m to t div 60 mod 60 as integer as string
	set s to t mod 60 as integer
	if s is less than 10 then
		set s to "0" & s as string
	end if
	if h is greater than 0 then
		return h & ":" & m & ":" & s as string
	else
		return m & ":" & s as string
	end if
end convertToTimestamp

tell application "Music"
	if player state is playing then
		set trackInfo to current track
		set rtnString to my convertToTimestamp(player position) & "/"
		set rtnString to rtnString & my convertToTimestamp(duration of trackInfo)
		return rtnString
	else
		return ""
	end if
end tell
