-- This script can be used in conjunction with Better Touch Tool to display the currently playing track on the MacBook Pro TouchBar
-- More info here: https://lucatnt.com/2017/02/display-the-currently-playing-track-in-itunesspotify-on-the-touch-bar

if application "Music" is running then
  tell application "Music"
    if player state is playing then
      return (get artist of current track) & " - " & (get name of current track)
    else
      return ""
    end if
  end tell
else
  return ""
end if
