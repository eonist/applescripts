(* 
 * Writes data to target_file (appends if append_data is true)
 * Note: if the target_file doesnt exisist it is created
 * @param target_file: needs to be in the hsf URL path format: "Macintosh HD:Users:John:Desktop:del.txt"
 * Todo: create a method for creating files, google it, you may also us she'll and touch and terminal and mkdir
 * Note: the eof value seems to be a special kind of value, it some how gets the length of the file without being set
 *)
on write_data(the_data, target_file, append_data) -- (string, file path as string, boolean)
	--log "writeData"
	try
		set the target_file to the target_file as text
		--log "target_file: " & target_file
		set the open_target_file to open for access file target_file with write permission
		--log "open_target_file: " & open_target_file
		if (append_data is false) then
			set eof of the open_target_file to 0 --write from the beginning of the file
		end if
		write the_data to the open_target_file starting at eof
		close access the open_target_file
		return true
	on error
		try
			close access file target_file
		end try
		return false
	end try
end write_data
(* 
 * Deletes the file at the file_path
 * Todo: what kind of file path?
 * Todo: impliment try error?
 *)
on delete_file(file_path)
	tell application "Finder"
		delete file file_path
	end tell
end delete_file
(*
 * Todo: what kind of file path?
 * Todo: complete me
 * Todo: untested
 *)
on rename_file(file_path, new_file_name)
	tell application "Finder"
		try
			set fileName to name of file_path
			log fileName
			set name of theFile to new_file_name --> rename the file
		on error
			log "error"
		end try
	end tell
end rename_file