property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property SQLiteUtil : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "sqlite:SQLiteUtil.applescript"))
property TextParser : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "text:TextParser.applescript"))
property TextModifier : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "text:TextModifier.applescript"))
(*
 * use -column or -line right after the sqlite3 statment to get different layout on the ret val
 * Returns the systems sql version: i.e: (*3.7.12*)
 * TODO should have filepath as an argument
 *)
on version_number()
	set head to "sqlite3" & space & "~/desktop/TestDB.db" & space & quote
	set select_version to "SELECT sqlite_version() AS 'SQLite Version;'"
	set shell_call to head & select_version & quote
	--log (shellCall)
	return (do shell script shell_call)
end version_number
(*
 * Returns table
 * Example  words of SQLiteParser's readTable(_dbFilePath, "countries", {"name"}) --use * to get the entire row, each row is seperated by a return char and each item is seperated by "|", use paragraphs of… to get a list
 * _rowid_
 *)
on read_table(file_path, table_name, querries)
	set loc to space & file_path & space
	set head to "sqlite3 " & loc & quote -- the "-line" option outputs the column data and heading one line at a time - useful for parsing the output for particular data items. -column also works TODO this option should be an argument in the method maybe
	set tail to quote
	set querry_text to TextParser's comma_delimited_text(querries)
	--log querry_text
	set procedure to "SELECT " & space & querry_text & space & "from " & table_name & "; " -- the "*" means get all rows. columns are separated by pipes ("|") in the result.
	log "procedure: " & procedure
	set the_table to do shell script head & procedure & tail
	return the_table
end read_table
(*
 * tableName is the name of the table
 * queries i.e: {"firstname","secondname"} the column slots you want in return do "*" to read the entire row with all column slots
 * Note: Remember to cast the "retVal as text" after calling this method if you want to manipulate it as you would any other text string
 * Example: log SQLiteParser's readRow(_dbFilePath, "people", {{"firstname", "Adam"}}, {"lastname"})
 * Note: _rowid_,oid,rowid always exists in each row
 * TODO add a method read_row_with_sub_str, add beginning, end to the params
 *)
on read_row(file_path, table_name, conditions, queries)
	set loc to space & file_path & space
	set head to "sqlite3 -column" & loc & quote
	set procedure to "SELECT" & space & TextParser's comma_delimited_text(queries) & space & "FROM" & space & table_name & space & "WHERE" & space & SQLiteUtil's condition_procedure(conditions, "AND") & ";"
	log "procedure: " & procedure
	--log head & procedure & quote
	set ret_val to do shell script head & procedure & quote
	--set result to words of retVal
	return ret_val
end read_row
(*
 * Returns the row count of a table
 * its possible to count only unique rows, and non null rows
 * its possible to sum and avg columns of non null values
 * Example log SQLiteParser's rowCount(_dbFilePath, "mods") --yields 3
 *)
on row_count(file_path, table_name)
	set loc to space & file_path & space
	set head to "sqlite3 " & loc & quote
	set count_procedure to "select count(*) from " & table_name & ";"
	set tail to quote
	return do shell script head & count_procedure & tail
end row_count
(*
 * Example: SQLiteParser's tableCount(_dbFilePath)
 *)
on table_count(file_path)
	log "table_count()"
	return number of words of table_names(file_path)
end table_count
(*
 * Example: SQLiteParser's columnCount(_dbFilePath, "colors")
 *)
on column_count(file_path, table_name)
	log "column_count"
	return number of column_names(file_path, table_name)
end column_count
(*
 * Returns the column names of a table
 * show log (do shell script "sqlite3 " & _dbFilePath & space & quote & ".show" & quote)
 * .separator : (to change the seperator)
 *)
on schema(file_path, table_name)
	log "schema()"
	return (do shell script "sqlite3 " & file_path & space & quote & ".schema " & table_name & quote)
end schema
(*
 * Returns the names of tables in the database
 * TD Return a list?
 *)
on table_names(file_path)
	return (do shell script "sqlite3 " & file_path & space & quote & ".tables" & quote)
end table_names
(*
 * Note could also be named subSelect
 * Example: SQLiteParser's innerJoin(_dbFilePath, "people", "countries", {"firstname", "lastname"}, "country_id", "id", {{"name", "Spain"}, {"name", "Usa"}})
 * Note: to get the count use SELECT count("*") or * to get the entire row
 *)
on inner_join(file_path, table_a, table_b, table_a_querries, table_a_condition, table_b_querry, table_b_Conditions)
	log "inner_join()"
	set table_a_querries_string to TextParser's comma_delimited_text(table_a_querries)
	--log tableAQuerriesString
	set table_b_conditions_string to SQLiteUtil's condition_procedure(table_b_Conditions, "OR")
	--log tableBConditionsString
	set procedure to "sqlite3 " & file_path & space & quote & "SELECT" & space & table_a_querries_string & space & "FROM" & space & table_a & space & "WHERE" & space & table_a_condition & space & "IN (SELECT" & space & table_b_querry & space & "FROM" & space & table_b & space & "WHERE" & space & table_b_conditions_string & ")" & ";" & quote
	--log procedure
	do shell script procedure
end inner_join
(*
 * Returns the column names as an array
 * Example: log first item of SQLiteParser's columnNames(_dbFilePath, "countries")
 * Note if PRAGMA is deperecated in future sqlite versions, then you can use log (do shell script "sqlite3 " & _dbFilePath & space & quote & "SELECT sql FROM sqlite_master WHERE name='countries';" & quote) instead
 * TODO ID isnt included?
 * TD Return list?
 *)
on column_names(file_path, table_name) --todo rename to column_keys
	log "column_names()"
	set table_schema to schema(file_path, table_name) --example of schema: CREATE TABLE people(firstname,  lastname,  country_id, phone_number);
	log table_schema
	set from_offset to offset of "(" in table_schema
	set to_offset to offset of ")" in table_schema
	set the_column_names to text (from_offset + 1) thru (to_offset - 1) of table_schema
	--log "the_column_names: " & the_column_names
	set ret_val to every word of the_column_names --TextParser's split(theColumnNames, ",  ") --apparently there are 2 spaces after each comma
	return ret_val
end column_names