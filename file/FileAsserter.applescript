--property FileAsserter : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "file:FileAsserter.applescript"))
property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property FileParser : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "file:FileParser.applescript"))
(*
 * Asserts if an alias hsf file path is a folder or not
 * Param the_path: "alias hsf" file path
 *)
on is_folder(the_path)
	return FileParser's file_kind(the_path) is equal to "folder"
end is_folder