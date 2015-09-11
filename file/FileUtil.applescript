property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property FileParser : my ScriptLoader's load(path to me, "FileParser.applescript")
log (path to me as text)
set the_path to POSIX path of ((path to me as text) & "::")
log the_path
log alias ((POSIX file the_path as text) & "FileParser.applescript")
log ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt")

set the_file_path to POSIX file ((path to me) as text)
log the_file_path

tell application "Finder" to get folder of (path to scripts folder from user domain) as Unicode text

set workingDir to POSIX path of result
log workingDir

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