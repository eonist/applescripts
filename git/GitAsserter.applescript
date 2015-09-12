--property GitAsserter : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "git:GitAsserter.applescript"))
property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property FileAsserter : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "file:FileAsserter.applescript"))
property GitUtil : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "git:GitUtil.applescript"))
(*
* Asserts if a folder has a git repository
* Example: is_git_repo("~/test/.git/")--true/false
* Note: Asserts 2 states: folder does not have a git repository, folder exists and has a git repository attatched, only returns true for the last case
* Note: Its wise to assert if the folder exists first, use FileAsserter's does_path_exist("~/test/.git/")
*)
on is_git_repo(posix_file_path)
	try
		GitUtil's status(posix_file_path, "")
		return true
	on error
		return false
	end try
end is_git_repo
(*
 * 
 *)
on has_remote_repo_attached(file_path, branch)
	try
		GitUtil's status(file_path, "origin" & "/" & branch)
		return true
	on error
		return false
	end try
end has_remote_repo_attached
(*
 * Asserts if a remote branch is ahead of a local branch
 *)
on is_remote_branch_ahead(local_repo_path, branch)
	set the_log to GitUtil's do_log(local_repo_path, "--oneline " & branch & ".." & "origin" & "/" & branch)--move this to the gitparser as a ref
	log the_log
	set log_list to paragraps of the_log
	if (length of log_list > 0) then
		return true
	else
		return false
	end if
end is_remote_branch_ahead
(*
 * you could also maybe use log to assert this, see is_remote_branch_ahead
 *)
on has_local_commits(local_repo_path, remote_path, branch)
	--move the bellow to gitModifier?
	log GitUtil's git_remote_update(local_path of repo_item) --in order for the cherry to work with "git add" that uses https, we need to call this method
	set cherry_result to GitUtil's cherry(local_repo_path)--move to parser
	log "cherry_result: " & cherry_result
	set has_commits to (length of cherry_result > 0)
	return has_commits
end has_local_commits