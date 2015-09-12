property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property TextAsserter : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "text:TextAsserter.applescript"))
(*
 * Add a file or many files to a commit
 * @param file_name is the file name you want to add, use * if you want to add all files
 * Caution: when a file is removed, the * char wont work, you have to add the file manually
 * Example: GitUtils's add(local_repo_path, "*")
 *)
on add(local_repo_path, file_name)
	if (TextAsserter's is_wrapped_in(file_name, "\"") = false) then --avoids quoting a file_name that is already quoated, this can happen when git removes a file
		set file_name to quoted form of file_name
	end if
	set shell_cmd to "cd " & local_repo_path & ";" & git_path & "git add" & " " & file_name
	log "shell_cmd: " & shell_cmd
	return do shell script shell_cmd
end add

(*
 * Commits current changes
 * NOTE: Commit , usually doesnt return anything
 * @Param: msg example: "created index.html file"
 * Return example: [master af86d55] added
 * 1 file changed, 0 insertions(+), 0 deletions(-)
 * create mode 100644 error.html
 * NOTE: its important that the message is betweentwo single quates
 * Example: GitUtils's commit(local_repo_path, "changes made")
 * TODO: can we also add desscription to a commit?
 * TODO: what does commit -a do? -all?
 * NOTE: There is no "extended description" concept in git. Only the commit message. What happens is that the commit message can have a single line or multiple lines External tools or websites such as git-cola or GitHub can interpret multiple lines commit messages as: The first line is a short description All the other lines are an extended description For one line messages, only the "short description" is defined.
 * TODO: git commit -m "Title" -m "Description .........." <--this works
 *)
on commit(local_repo_path, message_title, message_description)
	log "message_title: " & message_title
	return do shell script "cd " & local_repo_path & ";" & git_path & "git commit" & " " & "-m" & " '" & message_title & "' " & "-m" & " '" & message_description & "'"
end commit
(*
 * Uploads the current from the local git commits to the remote git
 * NOTE: if the remote history has diverged from your history, you need to pull the remote branch and merge it into your local one,
 * @param from_where: "master"
 * @param to_where: "origin"
 * NOTE: git push <remote> <branch> (Push the specified branch to <remote>, along with all of the necessary commits and internal objects. This creates a local branch in the destination repository. To prevent you from overwriting commits, Git won�t let you push when it results in a non-fast-forward merge in the destination repository.)
 * @param remote_repo_url: github.com/user-name/repo-name.git
 * NOTE: you may mitigate using username and pass by researching how to use SSH key in github from trusted maschines
 * TODO: maybe add try error when doing the shell part
 * TODO: add branch as a param
 * Example: GitUtils's push(local_repo_path, "github.com/user-name/repo-name.git", user_name, user_password)
 * NOTE: Original gti cmd: git push https://github.com/user/test.git master
 * NOTE: ssh-example: ssh://user@host/path/to/repo.git
 * NOTE: Only Push to Bare Repositories In addition, you should only push to repositories that have been created with the --bare flag. Since pushing messes with the remote branch structure, it�s important to never push to another developer�s repository. But because bare repos don�t have a working directory, it�s impossible to interrupt anybody�s developments.
 * NOTE: The only time you should ever need to force push is when you realize that the commits you just shared were not quite right and you fixed them with a git commit --amend or an interactive rebase. However, you must be absolutely certain that none of your teammates have pulled those commits before using the --force option.
 * NOTE: you can also do "git push" if you are already switched into the branch you want to push and there is only one remote repo attached to the local repo
 *)
on push(local_repo_path, remote_repo_url, user_name, user_password)
	set target_branch to "master" --master branch
	set remote_loc to "https://" & user_name & ":" & user_password & "@" & remote_repo_url --https://user:pass@github.com/user/repo.git--"origin"
	set shell_cmd to "cd " & local_repo_path & ";" & git_path & "git push" & " " & remote_loc & " " & target_branch
	log "shell_cmd: " & shell_cmd
	return do shell script shell_cmd
end push

(*
 * The opposite of the add action
 * Important: You should never use git reset <commit> when any snapshots after <commit> have been pushed to a public repository
 * NOTE: The * resets all
 * NOTE: git reset <file> --Removes a file from the staging area, 
 * NOTE: git reset --hard --Removes a file from the staging area and the actual file (does not remove an untracked file)
 * NOTE: git reset --Removes all files form the staging area, opposite of 
 * NOTE: git reset <commit> --reset the staging area to a specific commit id, this is great when you want to group a bunch of commits together
 * NOTE: git reset --hard <commit>--reset the staging area and the actual files to a specific commit id (does not remove untracked files)
 * NOTE: git reset --hard HEAD~2--resets 2 commits backward, also removes the actual files (does not remove untracked files)
 * NOTE: "git reset --hard" (Undo changes in tracked files)
 * NOTE: "git clean -df" (Remove untracked files, does not remove .ignored files, use "-xf" for that)
 *)
on reset(local_repo_path, file_name)
	return do shell script "cd " & local_repo_path & ";" & git_path & "git reset" & " " & file_name
end reset
(*
 * clean
 * NOTE: git clean -n --Perform a "dry run" of git clean. This will show you which files are going to be removed without actually doing it.
 * NOTE: git clean -f --Remove untracked files from the current directory. The -f (force) flag is required unless the clean.requireForce configuration option is set to false (it's true by default). This will not remove untracked folders or files specified by .gitignore.
 * NOTE: git clean -f <path> --Remove untracked files, but limit the operation to the specified path.
 * NOTE: git clean -df --Remove untracked files and untracked directories from the current directory.
 * NOTE: git clean -xf --Remove untracked files from the current directory as well as any files that Git usually ignores.
 *)
on clean()
	--condition 
end clean

(*
 * Downloads the current from the remote git to the local git
 * NOTE: the original git cmd is "git pull origin master"
 * NOTE: "https://user:pass@github.com/user/repo.git"
 * NOTE: returns "Already up-to-date." if there are nothing to pull from remote
 * TODO: Do we need login and pass for pulling? - for private repos, yes
 * NOTE: In the simplest terms, git pull does a git fetch followed by a git merge.
 * TODO: what is git pull --rebase <remote>. Same as the above command, but instead of using git merge to integrate the remote branch with the local one, use git rebase.
 * NOTE: git fetch followed by git merge, git pull rolls this into a single command. git fetch <remote> followed by git merge origin/<current-branch>.
 * NOTE: you can also do "git pull" if you are already switched into the branch you want to pull and there is only one remote repo attached to the local repo
 *)
on pull(local_repo_path, remote_repo_url, user_name, user_password)
	set remote_loc to "https://" & user_name & ":" & user_password & "@" & remote_repo_url
	set target_branch to "master" --master branch
	return do shell script "cd " & local_repo_path & ";" & git_path & "git pull" & " " & remote_loc & " " & target_branch
end pull


(*
 * The opposite of the add action
 * "git reset"
 *)
on revert()
	
end revert

(*
 * --rm --remove files, research this
 *)
on remove()
	
end remove
(*
 * Init
 *)
on init(local_repo_path)
	set shell_cmd to "cd " & local_repo_path & ";" & git_path & "git init"
	log "shell_cmd: " & shell_cmd
	return do shell script shell_cmd
end init
(*
 * Attach a remote repo to a local repo
 * NOTE: git remote add origin https://github.com/user/test.git
 * NOTE: git remote add john http://dev.example.com/john.git (YOu can also add other teammates git repos to the same repo as above)
 * NOTE: to retrive the origin url: "git config --get remote.origin.url"
 *)
on attach_remote_repo(local_repo_path, remote_repo_path)
	set shell_cmd to "cd " & local_repo_path & ";" & git_path & "git remote add origin" & " " & (quoted form of remote_repo_path)
	log "shell_cmd: " & shell_cmd
	return do shell script shell_cmd
end attach_remote_repo
(*
 * Detach a remote repo of a local repo
 * NOTE: the reverse of attach_remote_repo method
 * NOTE: git remote rm origin
 *)
on detach_remote_repo(local_repo_path)
	set shell_cmd to "cd " & local_repo_path & ";" & git_path & "git remote rm origin"
	log "shell_cmd: " & shell_cmd
	return do shell script shell_cmd
end detach_remote_repo
(*
 * Clone
 * NOTE: Cloning automatically creates a remote connection called "origin" pointing back to the original repository.
 * NOTE: git clone <repo> <directory>
 * NOTE: 
 *)
on clone(remote_path, local_path)
	set shell_cmd to git_path & "git clone " & remote_path & " " & local_path
	log "shell_cmd: " & shell_cmd
	return do shell script shell_cmd
end clone