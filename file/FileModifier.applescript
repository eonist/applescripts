(* 
 * Writes data to target_file (appends if append_data is true)
 * Note: if the target_file doesnt exisist it is created
 * Note: target_file needs to be in this url format: "Macintosh HD:Users:John:Desktop:del.txt"
 * Todo: create a method for creating files, you have this code in the SQLite edit project
 *)
on write_data(the_data, target_file, append_data) -- (string, file path as string, boolean)
	--log "writeData"
	try
		set the target_file to the target_file as text
		--log "target_file: " & target_file
		set the open_target_file to open for access file target_file with write permission
		--log "open_target_file: " & open_target_file
		if (append_data is false) then
			set eof of the open_target_file to 0--write from the beginning of the file
		end if
		write the_data to the open_target_file starting at eof--Todo: shouldnt the eof value be set to the length of the file before it is used?
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
 *)
on delete_file(file_path)
	tell application "Finder"
		delete file file_path
	end tell
end delete_file

