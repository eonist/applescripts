--property FileParser : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "file:FileParser.applescript"))
property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property TextParser : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "text:TextParser.applescript"))
(*
 * Only works if the file actually exists akak an alias
 * Reads the actual file
 * Example: FileParser's read_URL(POSIX path of (((path to desktop) as string) & "colors.xml"))--returns the content of xml on the desktop
 *)
on read_URL(file_URL)
	return (read POSIX file file_URL)
end read_URL
(*
 * Returns the POSIX path from a file path
 * Example: posix_path(Macintosh HD:Users:John:project:--"/Users/John/project/"
 *)
on posix_path(the_path)
	return POSIX path of the_path
end posix_path
(*
 * Returns the file url from a file path
 * Todo: write an example
 *)
on file_URL(file_path)
	--log "fileURL() filePath: " & filePath
	tell application "System Events"
		set the_URL to URL of file_path
		--log ("the_URL: " & the_URL)
		return the_URL
	end tell
end file_URL
(*
 * Returns a "hfs alias path" from a "POSIX path"
 * Example file_path(POSIX path of (path to desktop)): --"alias Macintosh HD:Users:John:Desktop:"
 *)
on file_path(fileURL)
	set posix_file to POSIX file fileURL
	return posix_file as alias
end file_path
(*
 * Returns a "hsf path" from an "alias hsf path"
 * Example: hfs_path(path to desktop)--"Macintosh HD:Users:John:Desktop:"
 *)
on hfs_path(file_path)
	return file_path as text --string and text can be used
end hfs_path
(*
 * Param the_hsf_file_path: Macintosh HD:Users:John:project:Text.txt
 * Returns: an alias object with the hsf file path
 * Note: you can cast as alias and as text to convert back and forth from hsf and alias hsf
 *)
on alias_file_path(the_hsf_file_path)
	return the_hsf_file_path as alias
end alias_file_path
(*
 * TODO:  Explain
 *)
on file_name_by_url(file_URL)
	return file_name(file_path(file_URL))
end file_name_by_url
(*
 * Returns the implicit path from a HSF file path
 *)
on implicit_file_URL(hfs_path)
	set posix_path to POSIX path of hfs_path
	set implicit_file_URL to "file://" & posix_path
	return implicit_file_URL
end implicit_file_URL
(*
 * Note can be used on files and folders
 * Example: FileParser's parent_folder(path to me)--"folder Macintosh HD:Users:John:projects:SomeProject:"
 * @Param file_path: HFS alias file type
 *)
on parent_folder(file_path)
	tell application "System Events"
		return container of file_path -- sets the parent folder of the folder you select
	end tell
end parent_folder
(*
 * posix_parent(path to me)--/Users/someUser/Library/Scripts/file/
 * NOTE: This method is great when you dont want to use system events to get the parent
 * NOTE: works on both files and folders
 *)
on posix_file_parent(alias_hsf_file_path)
	set parent_posix_file_path to POSIX path of ((alias_hsf_file_path as text) & "::")
end posix_file_parent
(*
 * Returns the parent path of @param alias_hsf_file_path
 *)
on alias_hsf_parent(alias_hsf_file_path)
	return alias ((alias_hsf_file_path as text) & "::")
end alias_hsf_parent
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
 * Example: name:test.db, creation date:date Thursday 29 August 2013 18:43:31, modification date:date Thursday 21 November 2013 20:07:41, size:28672, folder:false, alias:false, package folder:false, visible:true, extension hidden:false, name extension:db, displayed name:test.db, kind:Document, file type:
 *)
on file_info(the_file)
	info for the_file
end file_info
(*
 * Returns the file extension of the file, i.e: .zip
 * Note: its also possible to do it directly from the file, google it, or use regexp
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
 * the_folder: alias hsf file path
 * file_kind: "AppleScript text" or "JPEG image"
 *)
on file_names_of_kind(the_folder, file_kind)
	tell application "Finder"
		return name of files of folder the_folder whose (kind is file_kind) -- or kind is "AppleScript" 
	end tell
end file_names_of_kind
(*
 * Returns the file name from the file path
 * Todo: does it include the file extension?
 * Todo: does this work with posix?, if not make a note about how to convert hsf to posix
 * Note: works with hsf paths
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
(*
 * Returns an alias hfs file path from a POSIX file path
 *)
on alias_hfs_file_path(posix_file_path)
	set the_alias_hfs_file_path to POSIX file posix_file_path as alias
	return the_alias_hfs_file_path
end alias_hfs_file_path
(*
 * Returns an alias hfs file path from a POSIX file path
 *)
on hfs_file_path(posix_file_path)
	set the_alias_hfs_file_path to alias_hfs_file_path(posix_file_path)
	return the_alias_hfs_file_path as text --converts an "alias HFS file path" to a "HFS file path"
end hfs_file_path
(*
 * hfs_parent(path to me)--Macintosh HD:Users:John:SomeProject:
 *)
on hfs_parent_path(the_hsf_path)
	set the_parent_folder to parent_folder(the_hsf_path)
	set the_posix_path to file_URL(the_parent_folder)
	set the_hfs_file_path to hfs_file_path(the_posix_path)
	return the_hfs_file_path
end hfs_parent_path
(*
 * NOTE: edge case method
 *)
on full_hsf_path(folder_posix_path, file_name)
	return alias (folder_posix_path & file_name)
end full_hsf_path
(*
 * NOTE: edge case method
 *)
on full_hsf_paths(folder_posix_path, file_names)
	set file_paths to {}
	repeat with file_name in file_names
		set file_paths to file_paths & full_hsf_path(folder_posix_path, file_name)
	end repeat
	return file_paths
end full_hsf_paths
