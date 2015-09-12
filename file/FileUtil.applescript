property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
--property FileParser : my ScriptLoader's load(alias ((path to me as text) & "::"), "FileParser.applescript")
log alias ((alias ((path to me as text) & "::") as text) & "::")
log alias (((alias ((path to me as text) & "::")) as text) & "FileUtil.applescript")
log (path to parent of me)
(*
 * @param: file_path should be in posix format?
 *)
on open_file(file_path)
	tell application finder to open file_path
end open_file
(*
 * @param: file_paths should be a list of posix files
 *)
on open_files(file_paths)
	repeat with file_path in filepaths
		open_file(file_path)
	end repeat
end open_files