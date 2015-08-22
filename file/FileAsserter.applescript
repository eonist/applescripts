property FileParser : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "file:FileParser.applescript"))

(*
 * Todo: untested
 *)
on is_folder(the_path)
	return FileParser's file_kind(the_path) is equal to "folder
end is_folder