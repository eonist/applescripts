(*
 * @param: file_path should be in posix format?
 *)
on open_file(file_path)
	tell finder to open file_path
end open_file
(*
 * @param: file_paths should be a list of posix files
 *)
on open_files(file_paths)
	repeat with every file_path in filepaths
		open_file(file_path)
	end repeat
end open_files