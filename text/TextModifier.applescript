(*
 * Example : StringModifier's replaceText("Let it be known that [company] is responsible for any damage" & " any employee causes during [company]'s activity while in the conference.", "[company]", "Disny inc") -- this will then replace all instances of [company] with Disny inc
 *)
on replace_text(the_text, match, replacement)
	set text item delimiters to match
	set temporary_list to text items of the_text
	set text item delimiters to replacement
	set finished_form to temporary_list as text
	set text item delimiters to ""
	return finished_form
end replace_text
(*
 * Modifies the original array
 * TD you may aswell return the original array for chaining purposes
 *)
on wrap_every_text_item(text_items, wrap)
	repeat with i from 1 to (length of text_items)
		set item i of text_items to wrap_text(item i of text_items, wrap)
	end repeat
end wrap_every_text_item
(*
 * Does not modify the original string
 *)
on wrap_text(the_text, wrap)
	return wrap & the_text & wrap
end wrap_text