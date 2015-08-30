--property GitUtil : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "git:GitUtil.applescript"))
property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property TextAsserter : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "text:TextAsserter.applescript"))
property git_path : "/usr/local/git/bin/" --to execute git commands we need to call the git commands from this path
(*
 * Returns current git status
 * @param: local_repo_path is the path to the target repository on your local machine (posix path)
 * Note: ~/someProject/someProject.git (use the ~ char if you want to access the users homve folder in OSX)
 * Note: the cd is to move manouver into the local repository path, the ; char ends the call so you can make another call
 * Note: To obtaine a more meaningfull list of items, create a metod that compiles a multidim accociative array derived from the text based staus
 * Note: Appending -s simplifies the ret msg or you can also use --porcelain which does the same
 *)
on status(local_repo_path, option)
	return do shell script "cd " & local_repo_path & ";" & git_path & "git status" & " " & option
end status
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
 * Note: Commit , usually doesnt return anything
 * @param msg example: "created index.html file"
 * Return example: [master af86d55] added
 * 1 file changed, 0 insertions(+), 0 deletions(-)
 * create mode 100644 error.html
 * Note: its important that the message is betweentwo single quates
 * Example: GitUtils's commit(local_repo_path, "changes made")
 * Todo: can we also add desscription to a commit?
 * TODO: what does commit -a do? -all?
 * Note: There is no "extended description" concept in git. Only the commit message. What happens is that the commit message can have a single line or multiple lines External tools or websites such as git-cola or GitHub can interpret multiple lines commit messages as: The first line is a short description All the other lines are an extended description For one line messages, only the "short description" is defined.
 * TODO: git commit -m "Title" -m "Description .........." <--this works
 *)
on commit(local_repo_path, message_title, message_description)
	log "message_title: " & message_title
	return do shell script "cd " & local_repo_path & ";" & git_path & "git commit" & " " & "-m" & " '" & message_title & "' " & "-m" & " '" & message_description & "'"
end commit

(*
 * Uploads the current from the local git commits to the remote git
 * @param from_where: "master"
 * @param to_where: "origin"
 * @param remote_repo_url: github.com/user-name/repo-name.git
 * Note: you may mitigate using username and pass by researching how to use SSH key in github from trusted maschines
 * <<<<<<< HEAD
 * Todo: maybe add try error when doing the shell part
 * =======
 * Example: GitUtils's push(local_repo_path, "github.com/user-name/repo-name.git", user_name, user_password)
 * >>>>>>> origin/master
 * Note: Original gti cmd: git push https://github.com/user/test.git master
 * Note: ssh-example: ssh://user@host/path/to/repo.git
 *)
on push(local_repo_path, remote_repo_url, user_name, user_password)
	set from_where to "master" --master branch
	set to_where to "https://" & user_name & ":" & user_password & "@" & remote_repo_url --https://user:pass@github.com/user/repo.git--"origin"
	set shell_cmd to "cd " & local_repo_path & ";" & git_path & "git push" & " " & to_where & " " & from_where
	log "shell_cmd: " & shell_cmd
	return do shell script shell_cmd
end push
(*
 * The opposite of the add action
 * Important: You should never use git reset <commit> when any snapshots after <commit> have been pushed to a public repository
 * Note: The * resets all
 * Note: git reset <file> --Removes a file from the staging area, 
 * Note: git reset --hard --Removes a file from the staging area and the actual file (does not remove an untracked file)
 * Note: git reset --Removes all files form the staging area, opposite of 
 * Note: git reset <commit> --reset the staging area to a specific commit id, this is great when you want to group a bunch of commits together
 * Note: git reset --hard <commit>--reset the staging area and the actual files to a specific commit id (does not remove untracked files)
 * Note: git reset --hard HEAD~2--resets 2 commits backward, also removes the actual files (does not remove untracked files)
 *)
on reset(local_repo_path, file_name)
	return do shell script "cd " & local_repo_path & ";" & git_path & "git reset" & " " & file_name
end reset
(*
 * clean
 * Note: git clean -n --Perform a “dry run” of git clean. This will show you which files are going to be removed without actually doing it.
 * Note: git clean -f --Remove untracked files from the current directory. The -f (force) flag is required unless the clean.requireForce configuration option is set to false (it's true by default). This will not remove untracked folders or files specified by .gitignore.
 * Note: git clean -f <path> --Remove untracked files, but limit the operation to the specified path.
 * Note: git clean -df --Remove untracked files and untracked directories from the current directory.
 * Note: git clean -xf --Remove untracked files from the current directory as well as any files that Git usually ignores.
 *)
on clean()
	--condition 
end clean
(*
 * Downloads the current from the remote git to the local git
 * Note: the original git cmd is "git pull origin master"
 * Note: "https://user:pass@github.com/user/repo.git"
 * Note: returns "Already up-to-date." if there are nothing to pull from remote
 * TODO: : Do we need login and pass for pulling? - for private repos, yes
 * Note: In the simplest terms, git pull does a git fetch followed by a git merge.
 * // :TODO: what is git pull --rebase <remote>. Same as the above command, but instead of using git merge to integrate the remote branch with the local one, use git rebase.
 * Note: git fetch followed by git merge, git pull rolls this into a single command. git fetch <remote> followed by git merge origin/<current-branch>.
 *)
on pull(local_repo_path, remote_repo_url, user_name, user_password)
	set from_where to "https://" & user_name & ":" & user_password & "@" & remote_repo_url
	set to_where to "master" --master branch
	return do shell script "cd " & local_repo_path & ";" & git_path & "git pull" & " " & from_where & " " & to_where
end pull
(*
 * Cherry
 * Note: git cherry -v origin/master
 * Note: this can be used to assert if there are any local commits ready to be pushed, if there are local commits then text will be returned, if there arent then there will be no text
 * Caution: if you use git add with https login and pass, you need to run "git remote update" in order for the above note to work
 *)
on cherry(local_repo_path, user_name, user_password)
	set loc to "origin" --"https://" & user_name & ":" & user_password & "@" & remote_repo_url
	set what_branch to "master" --master branch
	return do shell script "cd " & local_repo_path & ";" & git_path & "git cherry" & " -v " & loc & "/" & what_branch--Todo: whats the -v, verbose?
end cherry
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
 * Note: git remote add origin https://github.com/user/test.git
 * Note: git remote add john http://dev.example.com/john.git (YOu can also add other teammates git repos to the same repo as above)
 *)
on attach_remote_repo(local_repo_path,remote_repo_path)
	set shell_cmd to "cd " & local_repo_path & ";" & git_path & "git remote add origin" & " " & (quoted form of remote_repo_path)
	log "shell_cmd: " & shell_cmd
	return do shell script shell_cmd
end attach_remote_repo
(*
 * Detach a remote repo of a local repo
 * Note: the reverse of attach_remote_repo method
 * Note: git remote rm origin
 *)
on detach_remote_repo(local_repo_path)
	set shell_cmd to "cd " & local_repo_path & ";" & git_path & "git remote rm origin"
	log "shell_cmd: " & shell_cmd
	return do shell script shell_cmd
end detach_remote_repo
(*
 * Clone
 * Note: Cloning automatically creates a remote connection called "origin" pointing back to the original repository.
 * Note: git clone <repo> <directory>
 * Note: 
 *)
on clone()

end clone
(*
 * Manually clone a git to a local folder
 * Note:  same as clone but differs in that it clones into an existing folder
 *)
on manual_clone(local_repo_path, remote_repo_path)
	--"git init" <--Installs the invisible .git folder
	--Todo: do reasearch with different posix paths ~/testing/ vs Users/Joe/testing vs macintosh hd/ user / etc, and how to convert between them
	--"git remote add origin https://github.com/user/testing.git" <-- attach a remote repo
	--"git fetch origin master" <--Download the latest .git data
	--"git checkout master" <-- Downloads all the **files** from the remote repo
	--"git fetch origin master" <-- Do this Again to download the latest .git data  , since your ahead sort of
end manual_clone
(*
 * Get a log of what is new, less verbose with pretty oneline
 * Note: git log --pretty=oneline
 * Note: "pretty=oneline" --get a log of what is new, less verbose with pretty oneline
 * Note: the cmd is: "git log"
 * Note: the do_log name is used because applescript has reserved the log word for its own log method
 *)
on do_log()

end do_log
(*
 * set your name and email
 * git config --global user.email you@example.com
 * git config --global user.name "your-user-name"
 *
 *)
on config()

end config
(*
 *
 * Note: the digits within the @@ and @@ signs represents indices of the lines that changed. Like: @@ -1 +1,3 @@,do a test with numbered lines from 1 - 16 and remove some to see the meaning like in this research: http://stackoverflow.com/questions/10950412/what-does-1-1-mean-in-gits-diff-output
 * Note: git diff returns a result if a file is removed (the removed file will look like this in the returned result: "--- path-to-removed-file")
 * Note: git diff does not reurn a result if a file is added
 * Note: git diff returns a result if a file is changed (the returned result will contain the lines that changed with a "-" preceding the line that is removed and a "+" preceding the line that is added)
 *)
on diff()

end diff
(*
 * Note: brings your remote refs up to date
 * Todo: Ellaborate
 *)
on git_remote_update(local_repo_path)
	return do shell script "cd " & local_repo_path & ";" & git_path & "git remote update"
end git_remote_update
(*
 * Note: git remote -v (List the remote connections you have to other repositories. include the URL of each connection.)
 * Note: git remote add <name> <url> (Create a new connection to a remote repository. After adding a remote, you’ll be able to use <name> as a shortcut)
 * Note: git remote rm <name> (Remove the connection to the remote repository called <name>.)
 * Note: git remote rename <old-name> <new-name> (Rename a remote connection from <old-name> to <new-name>.)
 *)
on remote()
	--condition 
end remote
(*
 * Checkout
 *)
on check_out()
	--condition
end check_out
(*
 * Fetch
 * Note: Fetching is what you do when you want to see what everybody else has been working on. Since fetched content is represented as a remote branch, it has absolutely no effect on your local development work. This makes fetching a safe way to review commits before integrating them with your local repository.
 * Note: The git fetch command downloads commits from a remote repository into your local repo, does not download the actual files
 * git fetch <remote> (Fetch all of the branches from the repository. This also downloads all of the required commits and files from the other repository.)
 * git fetch <remote> <branch> (Same as the above command, but only fetch the specified branch.)
 *)
on fetch()
	--condition
end fetch
(*
 * branch
 * Note: Remote branches are just like local branches, except they represent commits from somebody else’s repository. You can check out a remote branch just like a local one, but this puts you in a detached HEAD state (just like checking out an old commit). You can think of them as read-only branches. 
 * Note: you can inspect these branches with the usual git checkout and git log commands. If you approve the changes a remote branch contains, you can merge it into a local branch with a normal git merge.
 git branch -r
# origin/master
# origin/develop
# origin/some-feature
 *)
on branch()

end branch