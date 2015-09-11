property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property FileParser : my ScriptLoader's load_script(alias ((POSIX file (POSIX path of ((path to me as text) & "::")) as alias as text) & "FileParser.applescript"))
log (path to me as text)
set the_path to POSIX path of ((path to me as text) & "::")
log the_path
log ((POSIX file the_path as alias as text) & "FileParser.applescript")
log ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt")

set the_file_path to (path to me) as text
if (class of the_file_path = alias) then
	log "is alias"
else if (class of the_file_path = POSIX file) then
	log "is POSIX file"
else if (class of the_file_path = POSIX path) then
	log "is POSIX path"
else if (class of the_file_path = text) then
	log "is text"
end if

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