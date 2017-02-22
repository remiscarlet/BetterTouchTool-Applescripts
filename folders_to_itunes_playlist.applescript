set __PATH to "/Users/ytakamoto/Google Drive/THE iDOLM@STER"
set __ROOT_PLAYLIST_NAME to "THE iDOLM@STER"

on songExists(p, pl)
	try
		tell application "iTunes"
			set songList to tracks in pl
			if p is in songList then
				return true
			else
				return false
			end if
		end tell
	on error
		log "did not exist"
		return false
	end try
end songExists

on folderPlaylistExists(plName, pl)
	try
		tell application "iTunes"
			if pl is not "" then
				set foldNames to every playlist whose parent is pl
				repeat with fold in foldNames
					if name of fold is plName then
						return true
					end if
				end repeat
				return false
			else
				set tempthing to some folder playlist where name is plName
			end if
			return true
		end tell
	on error
		return false
	end try
end folderPlaylistExists

on playlistExists(plName, pl)
	try
		tell application "iTunes"
			repeat with fold in (some playlist where name is plName and special kind is none)
				if parent of fold is pl then
					return true
				end if
			end repeat
			return false
		end tell
	on error
		return false
	end try
end playlistExists

on isDirectory(somePath) -- someItem is a file reference
	if kind of (info for (POSIX file somePath)) is "folder" then
		return true
	else
		return false
	end if
end isDirectory

on strip(input)
	set filePath to input as text
	set Trimmed_filePath to do shell script "echo " & quoted form of filePath & " | sed -e 's/^[ ]*//' | sed -e 's/[ ]*$//'"
end strip

on createPlaylistFolder(path)
	
end createPlaylistFolder

on recTraverse(_PATH, pathList, currPlaylist)
	tell application "iTunes"
		set parentPlaylist to ""
		set firstTime to true
		repeat with i in list folder _PATH
			try
				copy pathList to newPathList
				if parentPlaylist is "" and _PATH is not my __PATH then
					set parentPlaylist to parent of currPlaylist
				end if
				
				-- Create your own regex/find-and-replace here if need to clean folder names to playlist names
				set newItem to (do shell script "perl -pe 's|\\[.*?\\] ||' <<<" & quoted form of i)
				-- set newItem to (do shell script "perl -pe 's|\\morestuff\\||' <<<" & quoted form of newItem)
				
				set end of newPathList to newItem
				set newPath to (POSIX path of _PATH & "/" & i)
				if my isDirectory(newPath) and newItem is not in {"Scans", "scans", "scan", "Scan"} then
					if not my folderPlaylistExists(newItem, currPlaylist) then
						make folder playlist in currPlaylist with properties {name:newItem}
					end if
					set newPlaylist to (some folder playlist where name is newItem)
					
					my recTraverse(newPath, newPathList, newPlaylist)
				else if newPath ends with ".mp3" then
					if firstTime then
						make playlist in parentPlaylist with properties {name:item -2 of newPathList}
						set newPlaylist to (some playlist where name is item -2 of newPathList and special kind is none)
						set firstTime to false
						delete currPlaylist
					end if
					if not my songExists(newPath, newPlaylist) then
						add (newPath as POSIX file as alias) to newPlaylist
					end if
				end if
			on error
				log "Meh."
				log _PATH & "/" & i
			end try
		end repeat
	end tell
end recTraverse

tell application "iTunes"
	if not my folderPlaylistExists(my __ROOT_PLAYLIST_NAME, "") then
		make folder playlist with properties {name:my __ROOT_PLAYLIST_NAME}
	end if
	set rootPlaylist to some playlist where name is my __ROOT_PLAYLIST_NAME and special kind is folder
	my recTraverse(__PATH, {}, rootPlaylist)
end tell
