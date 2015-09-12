property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property TextAsserter : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "text:TextAsserter.applescript"))
property git_path : "/usr/local/git/bin/" --to execute git commands we need to call the git commands from this path


(*
 * Manual pull
 * CAUTION: remember to wrap this method in a try error clause, so that you can handle merge conflicts
 * NOTE: the goal of this method is to arrive at the same state as the remote branch
 *)
on manual_pull(local_repo_path, remote_path, local_branch, remote_branch)
	log "manual_pull()"
	fetch(local_repo_path, remote_path, remote_branch) --git fetch origin master, retrive the latest repo info
	set is_remote_branch_ahead to GitAsserter's is_remote_branch_ahead(local_repo_path, remote_path, local_branch) --use the git log oneline thing here	--git log --oneline master..origin/master (to view the commit ids of the commits that the remote repo is ahead of local repo )
	
	log "is_remote_branch_ahead: " & is_remote_branch_ahead
	return --faux break
	if is_remote_branch_ahead then --asserts if a merge isneeded
		merge(local_file_path, local_branch, remote_branch) --git merge master origin/master (merges the changes from remote that you just fetched)
	end if
end manual_pull
(*
 * Cherry
 * NOTE: git cherry -v origin/master
 * TODO: impliment user and pass when this is needed, use "" if not
 * NOTE: this can be used to assert if there are any local commits ready to be pushed, if there are local commits then text will be returned, if there arent then there will be no text
 * Caution: if you use git add with https login and pass, you need to run "git remote update" in order for the above note to work
 *)
on cherry(local_repo_path, user_name, user_password)
	set loc to "origin" --"https://" & user_name & ":" & user_password & "@" & remote_repo_url
	set what_branch to "master" --master branch
	return do shell script "cd " & local_repo_path & ";" & git_path & "git cherry" & " -v " & loc & "/" & what_branch --TODO: whats the -v, verbose?
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
(*
 * Manually clone a git to a local folder
 * NOTE:  same as clone but differs in that it clones into an existing folder
 * TODO: this method is wrong see git workflows
 *)
on manual_clone(local_repo_path, remote_repo_path)
	--"git init" <--Installs the invisible .git folder
	--TODO: do reasearch with different posix paths ~/testing/ vs Users/Joe/testing vs macintosh hd/ user / etc, and how to convert between them
	--"git remote add origin https://github.com/user/testing.git" <-- attach a remote repo
	--"git fetch origin master" <--Download the latest .git data
	--"git checkout master" <-- Switches to the master branch (if you are already there then skip this)
	--"git fetch origin master" <-- Do this Again to download the latest .git data  , since your ahead sort of
end manual_clone
(*
 * Get a log of what is new, less verbose with pretty oneline
 * NOTE: git log --pretty=oneline
 * NOTE: "pretty=oneline" --get a log of what is new, less verbose with pretty oneline
 * NOTE: the cmd is: "git log"
 * NOTE: the do_log name is used because applescript has reserved the log word for its own log method
 * NOTE: git log --oneline
 * NOTE: "git log --oneline master..origin/master" to view the commit ids of the commits that the remote repo is ahead of local repo
 *)
on do_log(local_repo_path, cmd)
	set shell_cmd to "cd " & local_repo_path & ";" & git_path & "git log " & cmd
	log "shell_cmd: " & shell_cmd
	return do shell script shell_cmd
end do_log
(*
 * Config
 * NOTE: set your name: git config --global user.name "your-user-name"
 * NOTE: set your email: git config --global user.email you@example.com
 *)
on config()
	
end config
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
 * NOTE: brings your remote refs up to date
 * TODO: Ellaborate, it seems this method is needed to get the cherry method to work
 *)
on git_remote_update(local_repo_path)
	return do shell script "cd " & local_repo_path & ";" & git_path & "git remote update"
end git_remote_update
(*
 * NOTE: git remote -v (List the remote connections you have to other repositories. include the URL of each connection.)
 * NOTE: git remote add <name> <url> (Create a new connection to a remote repository. After adding a remote, you�ll be able to use <name> as a shortcut)
 * NOTE: git remote rm <name> (Remove the connection to the remote repository called <name>.)
 * NOTE: git remote rename <old-name> <new-name> (Rename a remote connection from <old-name> to <new-name>.)
 *)
on remote()
	--condition 
end remote
(*
 * Checkout
 * NOTE: When you switch between branches, the local files change accordingly
 * NOTE: to base a new branch of another branch do: "git checkout -b <new-branch> <existing-branch>"
 * NOTE: to create a new branch and switch to it do:"git checkout -b new-branch-name-here"
 * NOTE: "git checkout branch_name" is also a way to switch between your branches
 * NOTE: Checkout is a way to move back and forward in your code history. The git checkout command serves three distinct functions: checking out files, checking out commits, and checking out branches.
 * NOTE: git checkout works hand-in-hand with git branch. When you want to start a new feature, you create a branch with git branch, then check it out with git checkout. You can work on multiple features in a single repository by switching between them with git checkout
 * NOTE: To create a new branch adn start using it: "git branch new-feature" then "git checkout new-feature"
 * NOTE: git checkout <commit> <file> (checks out a spessific file from a spessific commit)
 * NOTE: git checkout <commit> (checks out all files from a spessific commit)
 * NOTE: git checkout HEAD hello.py (you can check out the most recent version with the following:)
 * NOTE: git checkout master hello.py (checks out a spessific file in a spessific branch)
 * NOTE: you can switch to a newly fetched branch with: "git checkout origin/master"
 * NOTE: after a merge you can use: "git checkout --thiers *" or "git checkout --ours *"
 * @param local_repo_path: path to the repository to operate on, must be absolute not relative
 * @param loc: can be branch like: origin/master or master or some_feature, or --ours, --theirs can also be an commit id
 * @param file_path: can be a relative file path, or the astrix sign for every file "*"
 *)
on check_out(local_repo_path, loc, file_path)
	set shell_cmd to "cd " & local_repo_path & ";" & git_path & "git checkout " & loc
	if file_path is not space then
		set shell_cmd to shell_cmd & " " & file_path
	end if
	log "shell_cmd: " & shell_cmd
	return do shell script shell_cmd
end check_out
(*
 * Fetch
 * NOTE: Fetching is what you do when you want to see what everybody else has been working on. Since fetched content is represented as a remote branch, it has absolutely no effect on your local development work. This makes fetching a safe way to review commits before integrating them with your local repository.
 * NOTE: The git fetch command downloads commits from a remote repository into your local repo, does not download the actual files
 * NOTE: git fetch <remote> (Fetch all of the branches from the repository. This also downloads all of the required commits and files from the other repository.)
 * NOTE: git fetch <remote> <branch> (Same as the above command, but only fetch the specified branch.)
 * NOTE: you can switch to the fetched branch with: "git checkout origin/master" then do "git log --oneline master..origin/master" to view the commit ids of the commits that the remote repo is ahead of local repo
 * TODO: does this work here: "git checkout --theirs *"  or "git checkout --ours *" 
 *)
on fetch(local_repo_path, remote_path, branch)
	log "fetch()"
	--condition
	set shell_cmd to "cd " & local_repo_path & ";" & git_path & "git fetch " & remote_path
	if branch is not space then
		set shell_cmd to shell_cmd & " " & branch
	end if
	log "shell_cmd: " & shell_cmd
	return do shell script shell_cmd
end fetch
(*
 * branch
 * NOTE: to delete a branch do: "git branch -d some-branch" (if you just merged the branch in, if not use -D)
 * NOTE: to delete a branch from a remote repo: "git push origin --delete some_branch" Delete the specified branch. This is a �safe� operation in that Git prevents you from deleting the branch if it has unmerged changes.
 * NOTE: you can check which branches you have open by doing "git branch"
 * NOTE: Remote branches are just like local branches, except they represent commits from somebody else�s repository. You can check out a remote branch just like a local one, but this puts you in a detached HEAD state (just like checking out an old commit). You can think of them as read-only branches. 
 * NOTE: you can inspect these branches with the usual git checkout and git log commands. If you approve the changes a remote branch contains, you can merge it into a local branch with a normal git merge.
 * NOTE: git branch -r
 * # origin/master
 * # origin/develop
 * # origin/some-feature
 * NOTE: git checkout -b new_branch_name_here (Create and check out <new-branch>. The -b option is a convenience flag that tells Git to run git branch <new-branch> before running )
 *)
on branch(target_branch, delete_flag)
	
end branch
(*
 * Merging is Git's way of putting a forked history back together again
 * NOTE: If the two branches you�re trying to merge both changed the same part of the same file, Git won�t be able to figure out which version to use. When such a situation occurs, it stops right before the merge commit so 
 * NOTE: Note that merge conflicts will only occur in the event of a 3-way merge. It�s not possible to have conflicting changes in a fast-forward merge.
 * NOTE: The current branch will be updated to reflect the merge, but the target branch will be completely unaffected. 
 * NOTE: to list all local branches in your repo do: "git branch"
 * NOTE: to list all remote branches in your repo do: "git branch -r"
 * NOTE: "git branch -D branch_name_here" Force delete the specified branch, even if it has unmerged changes. This is the command to use if you want to permanently throw away all of the commits associated with a particular line of development.
 * NOTE: "git merge --no-ff branch_name_here" Merge the specified branch into the current branch, but always generate a merge commit (even if it was a fast-forward merge). This is useful for documenting all merges that occur in your repository.
 * NOTE: "git merge branch_name_here" Merge the specified branch into the current branch. Git will determine the merge algorithm automatically (discussed below).
 * NOTE: To merge a branch into another branch: first switch to the branch you want to merge into by doing "git checkout master", then do "git merge some_branch"
 * NOTE: To check out and merge a branch inn one-line: "git merge target_branch new_branch" (aka: target_branch <-- new_branch)
 * NOTE: To merge a remote branch into your local branch do: "git fetch origin master", "git checkout master", "git merge origin/master", if you get conflicts and you just want to keep all your or their updates you do "git checkout --thiers *" or "git checkout --ours *" and then add and commit and push. Now you have merged perfectly
 * @param from_branch the branch you want to apply to the @param into_branch
 * @param into_branch is the branch you usually checkout before doing the merge
 *)
on merge(local_repo_path, into_branch, from_branch)
	set shell_cmd to "cd " & local_repo_path & ";" & git_path & "git merge " & into_branch & " " & from_branch
	log "shell_cmd: " & shell_cmd
	return do shell script shell_cmd
end merge
(*
 * rebase
 * NOTE: it seems rebasing is almost the same as merging, but with rebasing you also get the opertunity to squash commits into fewer commits, so when the rebasing is complete, the commit history looks will look simpler than with merging.
 * NOTE: The golden rule of git rebase is to never use it on public branches.
 * NOTE: One of the best ways to incorporate rebasing into your workflow is to clean up local, in-progress features. By periodically performing an interactive rebase, you can make sure each commit in your feature is focused and meaningful. This lets you write your code without worrying about breaking it up into isolated commits�you can fix it up after the fact.
 * NOTE: you can also squash together commits without merging: "git checkout feature" then "git rebase -i HEAD~3" By specifying HEAD~3 as the new base, you�re not actually moving the branch�you�re just interactively re-writing the 3 commits that follow it. Note that this will not incorporate upstream changes into the feature branch.
 * NOTE: If you would prefer a clean, linear history free of unnecessary merge commits, you should reach for git rebase instead of git merge when integrating changes from another branch.
 * NOTE: you switch to the branch you want to rebase and then do "git rebase master"
 * TODO: try "git rebase -i" see if it works as a commit squassher
 *)
on rebase()
	
end rebase

(*
 * stash
 * NOTE: plain old `git stash` won't touch files that are untracked. For this, you need to use `git stash -u`
 * NOTE: stash vs branch merge: branch merge creates an extra commit, use stash when your in the middle of some unfinished feature and you need to pause it where it is
 * NOTE: stash vs branch rebase: the jury is still out, need more research into rebase, but it could resolve the extra commit problem
 * NOTE: use names for each stash: git stash save Major refactor of foo before interruption
 * NOTE: apply stash: git stash apply stash@{1}
 * NOTE: applies the latest stash and removes it: git stash pop
 * NOTE: remove stashes: stash drop stash@{1}
 * NOTE: list all stashes: git stash list
 * NOTE: stash also removes all files in your directory as if you just did a "git reset --hard"
 * NOTE: when you apply your stash again, you may get file conflicts, resolve this as you would resolve a branch merge
 * TODO: test if you can use theirs and ours as you would in a regular merge
 * TODO: create 2 methods for stash, stash and stash_by_id, stash_at
 *)
on stash(title)
	--TODO: if no title is provided store the stash without title: by not including the save syntax
	--"git stash -u save " & title
end stash