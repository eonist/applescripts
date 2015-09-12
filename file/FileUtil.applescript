open_file(POSIX path of ((path to desktop as text) & "del.txt"))
(*
 * @param: file_path should be in posix format?
 *)
on open_file(file_path)
	log file_path
	--tell application "Finder" to open file_path
end open_file
(*
 * @param: file_paths should be a list of posix files
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