property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property SQLiteParser : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "sqlite:SQLiteParser.applescript"))
property SQLiteModifier : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "sqlite:SQLiteModifier.applescript"))
property SQLiteUtil : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "sqlite:SQLiteUtil.applescript"))
property ListParser : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "list:ListParser.applescript"))
property ListModifier : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "list:ListModifier.applescript"))
property FileModifier : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "file:FileModifier.applescript"))
property FileParser : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "file:FileParser.applescript"))
property TextParser : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "text:TextParser.applescript"))
(*
 * Promts a file browser
 *)
on choose_database_file()
	set file_path to alias choose file with prompt "Pick a .db file" of type {"DB"}
	log ("file_path: " & file_path)
	set the_file_path to FileParser's file_URL(file_path)
	log ("the_file_path: " & the_file_path)
	return the_file_path
end choose_database_file
(*
 * Promts a file browser
 * TODO explain better
 * a problem here if the user cancels, you can solve this by doing try , on error, end try... google it
 *)
on choose_file(title)
	log "choose_file()"
	set file_path to alias choose file with prompt title
	log ("file_path: " & file_path)
	set file_URL to FileParser's file_URL(file_path)
	log ("file_URL: " & file_URL)
	return file_URL
end choose_file
(*
 * Promts a file browser
 * TODO: explain better
 *)
on choose_file_name(title, file_name)
	log "choose_file_name()"
	set default_desktop_folder to (path to desktop folder as text) --set filePath to alias choose file with prompt "Pick a .db file" of type {"DB"}
	set file_path to choose file name with prompt title default location alias default_desktop_folder default name file_name
	log "filePath: " & file_path
	return file_path
end choose_file_name
(*
 * TODO: explain better
 * promts a save file dialog, choose a desired file name and export the file
 *)
on export_data(export_data)
	set file_path to my Helper's choose_file_name("Export data to file: ", "untitled.txt") --Choose the path and file name
	FileModifier's write_data(export_data, file_path, false)
end export_data
(*
 * TODO: explain better
 * promts a file save dialog, choose your desired file name and export
 *)
on create_new_database()
	set file_path to choose_file_name("Create a new database file:", "database.db")
	log ("file_path: " & file_path)
	set the_file_path to FileParser's implicit_file_URL(file_path)
	log "the_file_path: " & the_file_path
	SQLiteModifier's create_DB(the_file_path)
	return the_file_path
end create_new_database
(*
 * TODO: explain better
 * promts a lost dialog with the table names of the .db file, pick one item
 *)
on choose_table_name(file_path) --TODO rename to chooseTable
	log "choose_table_name()"
	--set db_file_path to my MainDialog's get_db_file_path()
	set table_names to words of SQLiteParser's table_names(file_path)
	log "table_names: " & table_names
	set the_selection to choose from list table_names with title "Select table" with prompt "Tables:" cancel button name "back"
	if the_selection is false then --aka user canceled
		--error number -128 -- User canceled--TODO should go back a step--aka user canceled
		--TODO promt something
		return missing value --TODO should probably go back to prev step
	else
		--my MainDialog's set_selected_table_name(item 1 of the_selection)
		return (item 1 of the_selection)
		--handleTableNameSelection() --TODO should return the picked table name
	end if
end choose_table_name
(*
 * TODO: explain better
 * promts a list dialog populated with all row id's in the @file_path and @table_name, pick an item or many
 *)
on choose_rows(file_path, table_name) --TODO move this method into Utils, because it is private or?
	log "choose_rows"
	set rows to paragraphs of SQLiteParser's read_table(file_path, table_name, {"_rowid_", "*"})
	log rows
	set the_selection to choose from list rows with title "Select row" with prompt "Rows:" cancel button name "back" with multiple selections allowed
	if the_selection is false then --aka user canceled
		--error number -128 -- User canceled--TODO should go back a step
		my MainDialog's show() --TODO should probably go back to prev step
	else
		set selected_rows to items of the_selection
		log "selected_rows: " & selected_rows
		return selected_rows
	end if
end choose_rows
(*
 * TODO: explain better
 * promts a list dialog populated with all collumn keys in the @file_path and @table_name, pick an item or many
 *)
on choose_column_keys(file_path, table_name)
	log "choose_column_keys"
	--then display column names w/ multi select
	set column_names to SQLiteParser's column_names(file_path, table_name)
	log "column_names: " & column_names
	set the_selection to choose from list column_names with title "Select column keys" with prompt "Column keys:" cancel button name "back" with multiple selections allowed --then handle the multi select,
	log "the_selection: " & the_selection
	if the_selection is false then --aka user canceled
		--error number -128 -- User canceled--TODO should go back a step--aka user canceled
		return missing value --TODO should probably go back to prev step
	else
		set selected_column_keys to items of the_selection
		log "selected_column_keys: " & selected_column_keys
		return selected_column_keys
		--handleColumnKeysSelection()
	end if
end choose_column_keys
(*
 * TODO: explain better
 * promts a list dialog populated with all collumn keys in the @file_path and @table_name, pick an item
 *)
on choose_column_key(file_path, table_name)
	log "choose_column_key"
	--then display column names w/ multi select
	set column_names to SQLiteParser's column_names(file_path, table_name)
	log "column_names: " & column_names
	set the_selection to choose from list column_names with title "Select column key" with prompt "Column keys:" cancel button name "back" --TODO handle the multi select,
	log "the_selection: " & the_selection
	if the_selection is false then --aka user canceled
		--error number -128 -- User canceled--TODO should go back a step--aka user canceled
		return missing value --TODO should probably go back to prev step
	else
		set selected_column_key to first item of the_selection
		log "selected_column_key: " & selected_column_key
		return selected_column_key
	end if
end choose_column_key
(*
 * TODO: explain better, what does it return?
 * promts a list dialog populated with all row id's in the @file_path and @table_name, pick an item
 * this method seems to also trim the length of a the row if it's too lengthy
 *)
on choose_row(file_path, table_name)
	--set selected_table_name to my MainDialog's get_selected_table_name()
	log "choose_row(): "
	--log "chooseRow(): " & _selectedAction & " _selectedTableName: " & _selectedTableName
	--log rows
	set rows to SQLiteParser's read_table(file_path, table_name, {"_rowid_", "*"})
	set row_list to paragraphs of rows --SQLiteParser's read_table(file_path, table_name, {"_rowid_", "*"})
	--log "table_rows: " & rows
	--NEW CODE
	set capped_rows to paragraphs of SQLiteUtil's cap_row_values(rows, 16) --caps each row item to 16 chars
	--log "capped_rows: " & capped_rows
	log "length of capped_rows: " & length of capped_rows
	--NEW CODE
	set table_column_keys to {"id"} & SQLiteParser's column_names(file_path, table_name)
	set the_column_keys to TextParser's delimited_text(table_column_keys, "|")
	log "the_column_keys: " & the_column_keys
	set the_selection to choose from list capped_rows with title "Select row" with prompt the_column_keys cancel button name "back"
	log "the_selection:" & the_selection
	if the_selection is false then --aka user canceled
		--error number -128 -- User canceled--TODO should go back a step
		return missing value --TODO should probably go back to prev step
	else
		log "the_selection: " & the_selection
		set selected_row to item 1 of the_selection --this is index and content of the item selected
		log "selected_row: " & selected_row
		set selected_row_index to ListParser's index_of(capped_rows, selected_row)
		log "selected_row_index: " & selected_row_index
		--my MainDialog's set_selected_row(selected_row)
		--set selected_row_id to first item of selected_row --this is the index of the item that is selected
		--log "selected_row_id: " & selected_row_id
		--my MainDialog's set_selected_row_id(selected_row_id)
		return item selected_row_index of row_list --selected_row
		--handleRowSelection()
	end if
end choose_row
(*
 * Retrive a row id by promting a list dialog and then pick a row, the row_id will be returned as text
 *)
on choose_row_id(file_path, table_name)
	log "choose_row_id()"
	return first item of choose_row(file_path, table_name)
end choose_row_id
(*
 * TODO explain better
 * NOTE does not include column in the pick list only row value
 * promts a list dialog populated with every value in a row, pick one row value to return it
 *)
on choose_row_value(selected_row)
	log "choose_row_value() "
	set row_items to items of TextParser's split(selected_row as text, "|")
	set the_selection to choose from list row_items with title "Select row value" with prompt "Row values:" cancel button name "back"
	log "the_selection: " & the_selection
	if the_selection is false then --aka user canceled
		--error number -128 -- User canceled--TODO should go back a step
		return missing value --TODO should probably go back to prev step
	else
		set selected_row_value to item 1 of the_selection
		log "selected_row_value: " & selected_row_value
		return selected_row_value
	end if
end choose_row_value
(*
 * the value is derived from picking table first, the col:row from a list 
 * same as choose_row_value but displays "column key : row value" in a alist
 * TODO: you may need to move this into the actual code again, since we may need to go back to prev step, and thats hard with this method
 *)
on choose_value(db_file_path)
	set temp_table_name to choose_table_name(db_file_path)
	set temp_chosen_row to choose_row(db_file_path, temp_table_name)
	log "temp_chosen_row: " & temp_chosen_row
	set temp_table_column_names to SQLiteParser's column_names(db_file_path, temp_table_name)
	set temp_table_column_keys to {"id"} & temp_table_column_names
	set temp_row_value_index to choose_row_value_index(temp_chosen_row, temp_table_column_keys)
	log "temp_row_value_index: " & temp_row_value_index
	log "temp_chosen_row: " & temp_chosen_row
	set row_items to items of TextParser's split(temp_chosen_row as text, "|")
	set temp_row_value to item temp_row_value_index of row_items
	log "temp_row_value: " & temp_row_value
	return temp_row_value
end choose_value
(*
 * TODO explain better
 * Returns a list of chosen values
 *)
on choose_row_values(selected_row)
	log "choose_row_values()"
	set row_items to items of TextParser's split(selected_row as text, "|")
	set the_selection to choose from list row_items with title "Select row value" with prompt "Row values:" cancel button name "back" with multiple selections allowed
	log "the_selection: " & the_selection
	if the_selection is false then --aka user canceled
		--error number -128 -- User canceled--TODO should go back a step
		return missing value --TODO should probably go back to prev step
	else
		set selected_row_values to items of the_selection
		log "selected_row_values: " & selected_row_values
		return selected_row_values
	end if
end choose_row_values
(*
 * Returns indices
 * NOTE: extract all row_items after the first if you dont want to include the id (this is built in for now)
 *)
on choose_row_value_indices(row, column_keys)
	log "choose_row_value_indices()"
	set row_items to items of TextParser's split(row as text, "|")
	set row_items to (items 2 thru (length of row_items) of row_items) --remove the first value in the row_items, since its the id
	--NEW CODE
	set capped_row_items to paragraphs of SQLiteUtil's cap_items(row_items, 16) --caps each row item to 16 chars
	--NEW CODE
	set selection_list to ListModifier's combine(column_keys, capped_row_items, ":")
	set the_selection to choose from list selection_list with title "Select row values" with prompt "Row values:" cancel button name "back" with multiple selections allowed
	log "the_selection: " & the_selection
	if the_selection is false then --aka user canceled
		--error number -128 -- User canceled--TODO should go back a step
		return missing value --TODO should probably go back to prev step
	else
		set selected_items to items of the_selection
		log "selected_items: " & selected_items
		set indices to ListParser's indices(selection_list, selected_items)
		log "indices: " & indices
		return indices
	end if
end choose_row_value_indices
(*
 * NEW
 * Returns an index
 *)
on choose_row_value_index(row, column_keys)
	log "choose_row_value_index()"
	set row_items to items of TextParser's split(row as text, "|")
	log "row_items: " & row_items
	set capped_row_items to paragraphs of SQLiteUtil's cap_values(row_items, 16) --caps each item in a list to 16 chars
	--set row_items to (items 1 thru (length of row_items) of row_items) --remove the first value in the row_items, since its the id
	set selection_list to ListModifier's combine(column_keys, capped_row_items, ":")
	log "selection_list: " & selection_list
	set the_selection to choose from list selection_list with title "Select row value" with prompt "Row values:" cancel button name "back"
	log "the_selection: " & the_selection
	if the_selection is false then --aka user canceled
		--error number -128 -- User canceled--TODO should go back a step
		return missing value --TODO should probably go back to prev step
	else
		set the_index to ListParser's index_of(selection_list, the_selection as text)
		log "the_index: " & the_index
		return the_index
	end if
end choose_row_value_index
(*
 * Returns column_key from a row_value
 * TODO: explain better
 *)
on column_key(file_path, table_name, the_row, the_row_value)
	set row_items to items of TextParser's split(the_row as text, "|")
	set index_of_row_value to ListParser's index_of(row_items, the_row_value as text)
	log "index_of_row_value: " & index_of_row_value
	set column_names to SQLiteParser's column_names(file_path, table_name)
	log "column_names: " & column_names
	set the_column_key to item (index_of_row_value - 1) of column_names --we subtract 1 because _rowid_ isnt included in the columntNames array
	log "the_column_key: " & the_column_key
	return the_column_key
end column_key
(*
 * TODO: explain better
 * probably returns a list of chosen col key's
 *)
on column_keys(file_path, table_name, the_row, row_values)
	log "column_keys()"
	set row_items to items of TextParser's split(the_row as text, "|")
	set indices_of_the_row_values to ListParser's indices(row_items, row_values)
	log "indices_of_the_row_values: " & indices_of_the_row_values
	set the_column_keys to {"id"} & SQLiteParser's column_names(file_path, table_name)
	log "the_column_keys: " & the_column_keys
	set the_selected_column_keys to ListParser's items_at(the_column_keys, indices_of_the_row_values)
	log "the_selected_column_keys:" & the_selected_column_keys
	return the_selected_column_keys
end column_keys
(*
 * Returns the row id from a row
 * TODO: explain better
 *)
on row_id(the_row)
	set row_items to items of TextParser's split(the_row as text, "|")
	set the_row_id to first item of row_items --the first item is always the _rowid_ 
	log "the_row_id: " & the_row_id
	return the_row_id
end row_id
