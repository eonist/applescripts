(* 
 * writes data to target_file (appends if append_data is true)
 * if the target_file doesnt exisist it is created
 * target_file needs to be in this url format: "Macintosh HD:Users:Jorgensen:Desktop:del.txt"
 *)
on write_data(this_data, target_file, append_data) -- (string, file path as string, boolean)
	--log "writeData"
	try
		set the target_file to the target_file as text
		--log "target_file: " & target_file
		set the open_target_file to open for access file target_file with write permission
		--log "open_target_file: " & open_target_file
		if append_data is false then Â
			set eof of the open_target_file to 0
		write this_data to the open_target_file starting at eof
		close access the open_target_file
		return true
	on error
		try
			close access file target_file
		end try
		return false
	end try
end write_data
--deletesnthe file at the file_path
on delete_file(file_path)
	tell application "Finder"
		delete file file_path
	end tell
end delete_file

