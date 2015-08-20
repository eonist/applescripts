(*
 * Example : StringModifier's replaceText("Let it be known that [company] is responsible for any damage" & " any employee causes during [company]'s activity while in the conference.", "[company]", "Disny inc") -- this will then replace all instances of [company] with Disny inc
 * Todo: is the original text also edited?
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
(*
 * returns the text in all lower case
 *)
on lower_case(the_text)
	set upper to "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	set lower to "abcdefghijklmnopqrstuvwxyz"
	return Util's translate_chars(the_text, upper, lower)
end lower_case
(*
 * returns the text in all upper case
 *)
on upper_case(the_text)
	set lower to "abcdefghijklmnopqrstuvwxyz"
	set upper to "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	return Util's translate_chars(the_text, lower, upper)
end upper_case
(*
 * Capitalize a text, returning only the first letter uppercased
 *)
on capitalize_text(the_text)
	set firstChar to upper_case(first character of the_text)
	set otherChars to lower_case(characters 2 thru -1 of the_text)
	return firstChar & otherChars
end capitalize_text
(*
 * removes trim string from the right side of the text
 *)
on left_side_strip(the_text, trim_string)
	set x to count trim_string
	try
		repeat while the_text begins with the trim_string
			set the_text to characters (x + 1) thru -1 of the_text as text
		end repeat
	on error
		return ""
	end try
	return the_text
end left_side_strip
(*
 * removes trim string from the right side of the text
 *)
on right_side_strip(the_text, trim_string)
	set x to count trim_string
	try
		repeat while the_text ends with the trim_string
			set the_text to characters 1 thru -(x + 1) of the_text as text
		end repeat
	on error
		return ""
	end try
	return the_text
end right_side_strip
(*
 * removes trim string from the left and right side of the text
 *)
on left_and_right_side_strip(the_text, trim_string)
	set the_text to left_side_strip(the_text, trim_string)
	set the_text to right_side_strip(the_text, trim_string)
	return the_text
end left_and_right_side_strip

script Util
	(*
	 * Translate characters of a text
	 * Note: Pass the From and To tables as strings (same lenght!)
	 *)
	on translate_chars(the_text, from_chars, to_chars)
		set the newText to ""
		if (count from_chars) is not equal to (count to_chars) then
			error "translate_chars: From/To strings have different lenght"
		end if
		repeat with char in the_text
			set newChar to char
			set x to offset of char in the from_chars
			if x is not 0 then set newChar to character x of the to_chars
			set newText to newText & newChar
		end repeat
		return the newText
	end translate_chars
end script