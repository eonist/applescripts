property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property GitUtil : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "git:GitUtil.applescript"))
(*
 * git diff --name-only --diff-filter=U "outputs: text2.txt"
 * git status -s "outputs UU text2.txt"
 *)
on unmerged_files(local_path)
	set unmerged_paths to GitUtil's diff(local_path,"--name-only --diff-filter=U")
  return paragraphs of unmerged_paths
end unmerged_files