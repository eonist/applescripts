property git_path : "/usr/local/git/bin/" --to execute git commands we need to call the git commands from this path
(*
 * Returns current git status
 * @param: local_repo_path is the path to the target repository on your local machine (posix path)
 * NOTE: ~/someProject/someProject.git (use the ~ char if you want to access the users homve folder in OSX)
 * NOTE: the cd is to move manouver into the local repository path, the ; char ends the call so you can make another call
 * NOTE: To obtaine a more meaningfull list of items, create a metod that compiles a multidim accociative array derived from the text based staus
 * NOTE: Appending -s simplifies the ret msg or you can also use --porcelain which does the same
 * NOTE: make the option param optional with an if clause
 *)
on status(local_repo_path, option)
	set local_repo_path to quoted form of local_repo_path & " | sed 's/ /\\\\ /g'"
	return do shell script "cd " &  local_repo_path & ";" & git_path & "git status" & " " & option
end status
(*
 * Retruns a log of what is new (less verbose with pretty oneline)
 * NOTE: "git log --pretty=oneline" --get a log of what is new, less verbose with pretty oneline
 * NOTE: the cmd is: "git log"
 * NOTE: the do_log name is used because applescript has reserved the log word for its own log method
 * NOTE: git log --oneline
 * NOTE: "git log --oneline master..origin/master" to view the commit ids of the commits that the remote repo is ahead of local repo
 * NOTE: "git log --oneline origin/master..master" commits the local branch is ahead of remote
 *)
on do_log(local_repo_path, cmd)
	set shell_cmd to "cd " & local_repo_path & ";" & git_path & "git log " & cmd
	--log "shell_cmd: " & shell_cmd
	return do shell script shell_cmd
end do_log
(*
 * "git diff --name-only --diff-filter=U" --returns a list of unmerged files
 * NOTE: the digits within the @@ and @@ signs represents indices of the lines that changed. Like: @@ -1 +1,3 @@,do a test with numbered lines from 1 - 16 and remove some to see the meaning like in this research: http://stackoverflow.com/questions/10950412/what-does-1-1-mean-in-gits-diff-output
 * NOTE: git diff returns a result if a file is removed (the removed file will look like this in the returned result: "--- path-to-removed-file")
 * NOTE: git diff does not reurn a result if a file is added
 * NOTE: git diff returns a result if a file is changed (the returned result will contain the lines that changed with a "-" preceding the line that is removed and a "+" preceding the line that is added)
 *)
on diff(local_repo_path, cmd)
	return do shell script "cd " & local_repo_path & ";" & git_path & "git diff " & cmd
end diff
(*
 * git diff --name-only --diff-filter=U "outputs: text2.txt"
 * git status -s "outputs UU text2.txt"
 *)
on unmerged_files(local_path)
	set unmerged_paths to diff(local_path, "--name-only --diff-filter=U")
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
(*
 * Cherry
 * NOTE: git cherry -v origin/master
 * TODO: impliment user and pass when this is needed, use "" if not
 * NOTE: this can be used to assert if there are any local commits ready to be pushed, if there are local commits then text will be returned, if there arent then there will be no text
 * Caution: if you use git add with https login and pass, you need to run "git remote update" in order for the above note to work
 * NOTE: branch: usually "master"
 *)
on cherry(local_repo_path, branch)
	set loc to "origin" --"https://" & user_name & ":" & user_password & "@" & remote_repo_url
	return do shell script "cd " & local_repo_path & ";" & git_path & "git cherry" & " -v " & loc & "/" & branch --TODO: whats the -v, verbose?
end cherry