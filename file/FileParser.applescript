(*
 * Returns "desktop/image.jpg" from desktop:image.jpg
 * HFS path is folder:folder and POSIX (unix) paths are folder/folder
 *)
property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property TextParser : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "text:TextParser.applescript"))

(* 
 * Only works if the file actually exists akak an alias
 * Reads the actual file
 *)
on read_URL(file_URL)
	return (read POSIX file file_URL)
end read_URL
--returns the POSIX path from a file path
--Todo write an example
on posix_path(the_path)
	return POSIX path of the_path
end posix_path
(*
 * returns the file url from a file path
 * Todo: write an example
 *)
on file_URL(file_path)
	--log "fileURL() filePath: " & filePath
	tell application "System Events"
		set the_URL to URL of file_path
		log ("the_URL: " & the_URL)
		return the_URL
	end tell
end file_URL
(*
 * Untest but should work
 *)
on file_path(fileURL)
	set posix_file to POSIX file fileURL
	return posix_file as alias
end file_path
(*
 * TD Explain
 *)
on file_name_by_url(file_URL)
	return file_name(file_path(file_URL))
end file_name_by_url
(*
 * returns the implicit path from a HSF file path
 *)
on implicit_file_URL(HFS_path)
	set posix_path to POSIX path of HFS_path
	set implicit_file_URL to "file://" & posix_path
	return implicit_file_URL
end implicit_file_URL
(*
 * Note can be used on files and folders
 *)
on parent_folder(file_path)
	tell application "System Events"
		return container of file_path -- sets the parent folder of the folder you select
	end tell
end parent_folder
(*
 * Note can be used on files and folders
 *)
on file_kind(file_path)
	tell application "System Events"
		return kind of file_path
	end tell
end file_kind
(*
 * Returns the file kind from a file_URL
 *)
on file_kind_by_URL(file_URL)
	return file_kind(file_path(file_URL))
end file_kind_by_URL
(*
 * Note can be used on files and folders
 * name of FileParser's fileProperties(the_file)
 * TODO get a list of properties
 *)
on file_properties(file_path)
	tell application "System Events"
		return properties of file_path
	end tell
end file_properties
(*
 * example: name:test.db, creation date:date Thursday 29 August 2013 18:43:31, modification date:date Thursday 21 November 2013 20:07:41, size:28672, folder:false, alias:false, package folder:false, visible:true, extension hidden:false, name extension:db, displayed name:test.db, kind:Document, file type:
 *)
on file_info(the_file)
	info for the_file
end file_info
(*
 * returns the file extension of the file, i.e: .zip
 *)
on file_extension(the_file)
	return name extension of (info for the_file)
end file_extension
(*
 * Folder names
 * Note can take POSIX file or Alias
 *)
on folder_names(the_folder)
	tell application "Finder"
		return name of folders of folder (the_folder)
	end tell
end folder_names
(*
 * Todo: does this method return file names and folder names
 *)
on file_names(the_folder)
	tell application "Finder"
		return name of files of folder (the_folder)
	end tell
end file_names
(*
 * Returns the file name from the file path
 * Todo: does it include the file extension?
 *)
on file_name(the_file_path)
	tell application "Finder"
		return name of the_file_path
	end tell
end file_name
(*
 * Returns all file names of all files in a folder
 * Todo: does this return folder names aswell?
 * Todo: create a method for single files that trims away the extension and loop this method instead
 *)
on file_names_sans_ext(the_folder)
	set temp_names to file_names(the_folder)
	set names to {}
	repeat with temp_name in temp_names
		set end of names to item 1 in TextParser's split(temp_name, ".")
	end repeat
	return names
end file_names_sans_ext
