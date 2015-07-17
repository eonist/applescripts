property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property SQLiteParser : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "sqlite:SQLiteParser.applescript"))
property SQLiteUtil : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "sqlite:SQLiteUtil.applescript"))
property ListModifier : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "list:ListModifier.applescript"))
property TextParser : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "text:TextParser.applescript"))
property TextModifier : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "text:TextModifier.applescript"))
(*
 * Creates a database
 * theFilePath "~/desktop/TestDB.db"
 * TODO: test how to use POSIX filepath and the other format for filePath
 *)
on create_db(file_path)
	set loc to space & file_path & space
	set head to "sqlite3" & loc & quote -- "head" is the opening statement of every future command to our db.-- "head" tells SQLite where to put our db if it doesn't exist, identifies it if it does.
	set tail to quote -- "tail" ends every query started with "head".
	do shell script head & tail -- And finally, build the SQLite query and execute it
end create_db
(*
 * table_name : "mods"
 * file_path : "~/desktop/TestDB.db"
 * column_ids : {"firstname", "lastname", "country"}
 * TODO you should be able to also set the column_key_type somehow
 * The data type comes after the col_key like: age INT, first_name TEXT, birth_day DATE etc
 * TYPES in SQLite INT REAL (number) TEXT BLOB, what about NULL and NONE? UINT? BOOLEAN doesnt exist in SQLite use int and ask if its true or false when reading the value, DATE doesnt exist, use text,number or int, 
 *)
on create_table(file_path, table_name, column_ids)
	set loc to space & file_path & space
	set head to "sqlite3" & loc & quote -- the "-line" option outputs the column data and heading one line at a time - useful for parsing the output for particular data items.
	set tail to quote
	set the_column_ids to TextParser's comma_delimited_text(column_ids)
	log "the_column_ids: " & the_column_ids
	set new_table to "create table " & table_name & "(" & the_column_ids & "); " --TODO: Create table should be a constant and in caps?
	do shell script head & new_table & tail
end create_table
(*
 * inserts a row
 * Example: SQLiteModifier's insertRow(_dbFilePath, "countries", {"name", "continent", "capital"}, {"England", "Europe", "London"})
 * Note: there are 2 ways to insert rows the bellow and a way were you dont have to define the keys, but that way doesnt work when a primary key is present
 * TODO: make the method described above, its easy see pdf, and you had these method before you upgraded this one
 *)
on insert_row(file_path, table_name, keys, row) --todo rename row to values
	log "insert_row()"
	set loc to space & file_path & space
	set head to "sqlite3" & loc & quote -- "head" tells SQLite where to put our db if it doesn't exist, identifies it if it does.-- "head" is the opening statement of every future command to our db.
	set tail to quote -- "tail" ends every query started with "head".
	TextModifier's wrap_every_text_item(row, "'")
	set the_keys to TextParser's comma_delimited_text(keys)
	set the_row to TextParser's comma_delimited_text(row)
	set insert_command to "insert into " & table_name & "(" & the_keys & ")" & " values(" & the_row & "); "
	do shell script head & insert_command & tail -- And finally, build the SQLite query and execute it
end insert_row
(*
 * Example: SQLiteModifier's updateRows(_dbFilePath, "mods", {{"country","Uk"}}, {{"country","England"}})
 *)
on update_rows(file_path, table_name, conditions, input)
	set loc to space & file_path & space
	set head to "sqlite3 -column" & loc & quote
	set the_input to SQLiteUtil's condition_procedure(input, ",")
	log "the_input: " & the_input
	set the_conditions to SQLiteUtil's condition_procedure(conditions, "AND")
	log "the_conditions: " & the_conditions
	set procedure to "update " & table_name & " set " & the_input & " where " & the_conditions & "; " -- country = 'England' 
	log "procedure: " & procedure
	set tail to quote
	log head & procedure & tail
	do shell script head & procedure & tail
end update_rows
(*
 * Note: dataSet can only have one item, this can probably be fixed in the future
 * Example: SQLiteModifier's updateRow(_dbFilePath, "countries", {{"id", "4"}}, {{"capital", "Ottawa"}})
 *)
on update_row(file_path, table_name, condition, data_set)
	set the_condition to SQLiteUtil's condition_procedure(condition, "AND")
	log "the_condition: " & the_condition
	set the_data_set to SQLiteUtil's condition_procedure(data_set, "AND")
	log "the_data_set: " & the_data_set
	set procedure to "sqlite3" & space & file_path & space & quote & "UPDATE" & space & table_name & space & "SET" & space & the_data_set & space & "WHERE" & space & the_condition & ";" & quote
	log "procedure: " & procedure
	do shell script procedure
end update_row
(*
 * removes a table from a database
 *)
on remove_table(file_path, table_name)
	set loc to space & file_path & space
	set head to "sqlite3" & loc & quote -- the "-line" option outputs the column data and heading one line at a time - useful for parsing the output for particular data items.
	set procedure to "drop table " & table_name & "; "
	set tail to quote
	do shell script head & procedure & tail
end remove_table
(*
 * rename a table
 *)
on rename_table(file_path, table_name, new_table_name)
	set procedure to "sqlite3" & space & file_path & space & quote & "ALTER TABLE" & space & table_name & space & "RENAME TO" & space & new_table_name & ";" & quote
	do shell script procedure
end rename_table
(*
 * transfere table
 *)
on transfer_table(file_path, from_table, to_table, from_column_keys, to_column_keys)
	set from_column_keys_string to TextParser's comma_delimited_text(from_column_keys)
	log "from_column_keys_string: " & from_column_keys_string
	set to_column_keys_string to TextParser's comma_delimited_text(to_column_keys)
	log "to_column_keys_string: " & to_column_keys_string
	set procedure to "sqlite3" & space & file_path & space & quote & "INSERT INTO" & space & to_table & "(" & to_column_keys_string & ")" & space & "SELECT" & space & from_column_keys_string & space & "FROM" & space & from_table & ";" & quote
	--log "procedure: " & procedure
	do shell script procedure
end transfer_table
(*
 * TODO: in the future do all the procedures in the bellow method in one db call !?!
 * Example: SQLiteModifier's renameColumn(_dbFilePath, "colors", "color", "val")
 *)
on rename_columns(file_path, table_name, old_column_names, new_column_names) --TODO rename to columnKey and newColumnKey
	log "rename_columns()"
	set column_names_string to SQLiteParser's column_names(file_path, table_name) --use the SQLiteParser's columnNames() to get the columnnames
	set temp_table_name to "_TEMP_TABLE_"
	rename_table(file_path, table_name, temp_table_name) --rename original table to "a temp name"
	set column_names to every item of column_names_string
	--ListModifier's replace(newColumnNames, columnName, newColumnName)
	ListModifier's replace_many(column_names, old_column_names, new_column_names)
	log "column_names: " & column_names
	create_table(file_path, table_name, column_names) --create a new table with the same columnNames, and replace the columnName with newColumnName
	transfer_table(file_path, temp_table_name, table_name, column_names_string, column_names) --use the transferTable method (figure out if you need the column name or if you can use the column name and meta data etc)
	remove_table(file_path, temp_table_name) --remove the temp table
end rename_columns
(*
 * swap columns
 *)
on swap_columns(file_path, table_name, coloumn_key_a, column_key_b)
	log "swap_columns()"
	swap_column_data(file_path, table_name, coloumn_key_a, column_key_b)
	swap_column_keys(file_path, table_name, coloumn_key_a, column_key_b)
end swap_columns
(*
 * swap column keys
 *)
on swap_column_keys(file_path, table_name, coloumn_key_a, column_key_b)
	log "swap_column_keys"
	set column_names to SQLiteParser's column_names(file_path, table_name)
	set new_colum_names to every item of column_names
	ListModifier's swap(new_colum_names, coloumn_key_a, column_key_b)
	log new_colum_names
	--rename the old table to _TEMP_TABLE_
	set temp_table_name to "_TEMP_TABLE_"
	rename_table(file_path, table_name, temp_table_name) --rename original table to "a temp name"
	--create a new table with the old name and the new column arrangment
	create_table(file_path, table_name, new_colum_names)
	--transfere from the old column_keys to the new arangment
	transfer_table(file_path, temp_table_name, table_name, column_names, new_colum_names)
	--remove the temp table
	remove_table(file_path, temp_table_name) --remove the temp table
end swap_column_keys
(*
 * Swaps the content of each row from one column key to another column key
 *)
on swap_column_data(file_path, table_name, coloumn_key_a, column_key_b)
	--update mytable set coloumn_key_a = column_key_b, column_key_b = coloumn_key_a
	set procedure to "sqlite3" & space & file_path & space & quote & "UPDATE" & space & table_name & space & "SET" & space & coloumn_key_a & space & "=" & space & column_key_b & space & "," & space & column_key_b & space & "=" & space & coloumn_key_a & ";" & quote
	log "procedure: " & procedure
	do shell script procedure
end swap_column_data
(*
 * Note assert if the column exists with the SQLiteAsserter's hasColumn(dbFilePath,tableName,columnName)
 *)
on remove_columns(file_path, table_name, column_names)
	log "remove_columns()"
	set current_column_names to SQLiteParser's column_names(file_path, table_name) --get the columnNames
	set temp_table_name to "_TEMP_TABLE_" --create tempTableName
	rename_table(file_path, table_name, temp_table_name) --rename the original table with the tempTableName
	set new_column_names to every item of current_column_names --store the columnNames
	set new_column_names to ListModifier's remove_many(new_column_names, column_names) --ListModifier's removeItem(newColumnNames, columnName)
	create_table(file_path, table_name, new_column_names) --create the new table
	transfer_table(file_path, temp_table_name, table_name, new_column_names, new_column_names) --transferTable
	remove_table(file_path, temp_table_name) --remove the temp table
end remove_columns
(*
 * Example: SQLiteModifier's removeRow(_dbFilePath, "people", {{"firstname", "Ray"}, {"lastname", "Barber"}})
 *)
on remove_row(file_path, table_name, condition)
	log "remove_row()"
	set condition_string to SQLiteUtil's condition_procedure(condition, "AND")
	log condition_string
	set procedure to "sqlite3" & space & file_path & space & quote & "DELETE" & space & "FROM" & space & table_name & space & "WHERE" & space & condition_string & ";" & quote
	log procedure
	do shell script procedure
end remove_row
(*
 * Example SQLiteModifier's addColumn(_dbFilePath, "temp", "attribute")
 *)
on add_column(file_path, table_name, column_name)
	log "add_column()"
	set procedure to "sqlite3" & space & file_path & space & quote & "ALTER" & space & "table" & space & table_name & space & "ADD" & space & "column" & space & column_name & space & ";" & quote
	log procedure
	do shell script procedure
end add_column
(*
 * add columns to a table
 *)
on add_columns(file_path, table_name, column_names)
	log "add_columns()"
	repeat with i from 1 to (length of column_names)
		add_column(file_path, table_name, (item i of column_names))
	end repeat
end add_columns
--DO THE TELEPHONE APP ON THE MACSCRIPTER SITE
-- do research into instantiating an instance in applescript with a constructor etc, can it be done
-- try to make the interface for the db with this instance