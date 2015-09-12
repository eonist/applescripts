property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property GitUtil : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "git:GitUtil.applescript"))
property git_path : "/usr/local/git/bin/" --to execute git commands we need to call the git commands from this path
(*
 * git diff --name-only --diff-filter=U "outputs: text2.txt"
 * git status -s "outputs UU text2.txt"
 *)
on unmerged_files(local_path)
	set unmerged_paths to GitUtil's diff(local_path, "--name-only --diff-filter=U")
	return paragraphs of unmerged_paths
end unmerged_files
(*
 *Returns https://github.com/user/repository.git
 *)
on origin_url(local_repo_path)
	set shell_cmd to "cd " & local_repo_path & ";" & git_path & "git config --get remote.origin.url"
	--log "shell_cmd: " & shell_cmd
	return do shell script shell_cmd
end origin_url