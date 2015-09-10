(*
 * git diff --name-only --diff-filter=U "outputs: text2.txt"
 * git status -s "outputs UU text2.txt"
 *)
on merge_conflict_files(local_path)
	set the_status to GitUtil's staus(local_path,"-s")
	return paragraphs of the_status
end merge_conflict_files