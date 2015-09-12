
(*
 * @param: file_path should be in "hsf" or "alias hsf"
 * Example: open_file((path to desktop as text) & "del.txt")
 *)
on open_file(file_path)
	log file_path
	tell application "Finder" to open file_path
end open_file
(*
 * @param: file_paths should be a list of "hsf" or "alias hsf" paths
 *)
on open_files(file_paths)
	repeat with file_path in filepaths
		open_file(file_path)
	end repeat
end open_files
(*
 *
 *)
on open_many(folder_path, file_names)
	
end open_many