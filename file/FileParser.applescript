--Returns "desktop/image.jpg" from desktop:image.jpg
--HFS path is folder:folder and POSIX (unix) paths are folder/folder
property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property TextParser : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "text:TextParser.applescript"))


--Only works if the file actually exists akak an alias
--Reads the actual file
on read_URL(file_URL)
	return (read POSIX file file_URL)
end read_URL
--
on posix_path(the_path)
	return POSIX path of the_path
end posix_path
--
on file_URL(file_path)
	--log "fileURL() filePath: " & filePath
	tell application "System Events"
		set the_URL to URL of file_path
		log ("the_URL: " & the_URL)
		return the_URL
	end tell
end file_URL
--Untest but should work
on file_path(fileURL)
	set posix_file to POSIX file fileURL
	return posix_file as alias
end file_path
--TD Explain
on file_name_by_url(file_URL)
	return file_name(file_path(file_URL))
end file_name_by_url
--
on implicit_file_URL(HFS_path)
	set posix_path to POSIX path of HFS_path
	set implicit_file_URL to "file://" & posix_path
	return implicit_file_URL
end implicit_file_URL
--Note can be used on files and folders
on parent_folder(file_path)
	tell application "System Events"
		return container of file_path -- sets the parent folder of the folder you select
	end tell
end parent_folder
--Note can be used on files and folders
on file_kind(file_path)
	tell application "System Events"
		return kind of file_path
	end tell
end file_kind
--
on file_kind_by_URL(file_URL)
	return file_kind(file_path(file_URL))
end file_kind_by_URL
--Note can be used on files and folders
--name of FileParser's fileProperties(the_file)
--TODO get a list of properties
on file_properties(file_path)
	tell application "System Events"
		return properties of file_path
	end tell
end file_properties
--(*name:test.db, creation date:date Thursday 29 August 2013 18:43:31, modification date:date Thursday 21 November 2013 20:07:41, size:28672, folder:false, alias:false, package folder:false, visible:true, extension hidden:false, name extension:db, displayed name:test.db, kind:Document, file type:
on file_info(the_file)
	info for the_file
end file_info
--
on file_extension(the_file)
	return name extension of (info for the_file)
end file_extension
--Folder names
--Note can take POSIX file or Alias
on folder_names(the_folder)
	tell application "Finder"
		return name of folders of folder (the_folder)
	end tell
end folder_names
--
on file_names(the_folder)
	tell application "Finder"
		return name of files of folder (the_folder)
	end tell
end file_names
--
on file_name(the_file_path)
	tell application "Finder"
		return name of the_file_path
	end tell
end file_name
--
on file_names_sans_ext(the_folder)
	set temp_names to file_names(the_folder)
	set names to {}
	repeat with temp_name in temp_names
		set end of names to item 1 in TextParser's split(temp_name, ".")
	end repeat
	return names
end file_names_sans_ext