property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property TextParser : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "text:TextParser.applescript"))
property TextModifier : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "text:TextModifier.applescript"))
(*
 * Example: Returns in this format: firstname = 'Ray' and lastname = 'Barber'
 * Alteration can be eigther "AND" or "OR"
 *)
on condition_procedure(conditions, alteration)
	log "condition_procedure()"
	set condition_text to ""
	repeat with i from 1 to (length of conditions)
		set theItem to item i of conditions
		set text item delimiters to ","
		set temporary_list to text items of theItem
		set item 2 of temporary_list to TextModifier's wrap_text(item 2 of temporary_list, "'")
		set text item delimiters to " = "
		set finished_form to temporary_list as text
		set tail to space & alteration & space
		if i = (length of conditions) then
			set tail to ""
		end if
		set condition_text to condition_text & finished_form & tail
	end repeat
	return condition_text
end condition_procedure
(*
 * caps items that are longer than cap_len and adds 3 punctuation characters "..."  to the end of the capped text
 *)
on cap_row_values(the_text, cap_len)
	log "cap_row_values()"
	return cap_values(paragraphs of the_text, cap_len)
end cap_row_values
(*
 * Caps values that are longer then the alpwed length specified in the @param cap_len
 *)
on cap_values(the_list, cap_len)
	log "cap_values ()"
	set return_text to ""
	repeat with i from 1 to (length of the_list)
		set row to item i of the_list
		set the_items to items of TextParser's split(row as text, "|")
		repeat with e from 1 to (length of the_items)
			set the_item to item e of the_items
			if length of the_item > cap_len then
				set the_item to (text 1 thru cap_len of the_item) & "..."
			end if
			set return_text to return_text & the_item
			if e < length of the_items then
				set return_text to return_text & "|"
			end if
		end repeat
		if i < length of the_list then --add a line break after, only if its not the last line
			set return_text to return_text & return
		end if
	end repeat
	return return_text
end cap_values
(*
 * TODO: could we use an utility method named cap_text inside the loop?
 *)
on cap_items(the_list, cap_len)
	set return_text to ""
	repeat with i from 1 to (length of the_list)
		set the_item to item i of the_list
		if length of the_item > cap_len then --only cap items that are longer than cap_len
			set the_item to (text 1 thru cap_len of the_item) & "..."
		end if
		set return_text to return_text & the_item
		if i < length of the_list then --add a line break after, only if its not the last line
			set return_text to return_text & return
		end if
	end repeat
	return return_text
end cap_items