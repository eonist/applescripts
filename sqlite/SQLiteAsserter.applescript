property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property SQLiteUtil : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "sqlite:SQLiteUtil.applescript"))
property TextParser : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "text:TextParser.applescript"))
--Asserts if a database has a specific table
--OPTIONAL CODE: SELECT name FROM sqlite_master WHERE type='table' AND name='table_name';
--Example log SQLiteAsserter's hasTable(_dbFilePath, "colors")
on has_table(file_path, table_name)
	try
		SQLiteParser's read_table(file_path, table_name)
		return true
	on error --table does not exist
		return false
	end try
end has_table
--Asserts if a table in a database has a column by the name of @column_name
--TODO we might be able to use the readColumn method here
on has_column(file_path, table_name, column_name)
	try
		do shell script "sqlite3" & space & file_path & space & quote & "SELECT" & space & column_name & space & "FROM" & space & table_name & ";" & quote
		return true
	on error --column does not exist
		return false
	end try
end has_column
--Asserts if a table in a database has a specific row
--Example log SQLiteAsserter's hasRow(_dbFilePath, "colors", {{"name", "kaki"}}) --true
on has_row(file_path, table_name, conditions)
	return length of SQLiteParser's read_row(file_path, table_name, conditions, {"*"}) > 0
end has_row
--TODO create the assert method for a value in a row etc
