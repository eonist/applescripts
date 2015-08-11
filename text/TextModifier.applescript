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

-- Translate characters of a text
-- Note: Pass the From and To tables as strings (same lenght!)
-- todo move to util class
on translateChars(theText, fromChars, toChars)
	set the newText to ""
	if (count fromChars) is not equal to (count toChars) then
		error "translateChars: From/To strings have different lenght"
	end if
	repeat with char in theText
		set newChar to char
		set x to offset of char in the fromChars
		if x is not 0 then set newChar to character x of the toChars
		set newText to newText & newChar
	end repeat
	return the newText
end translateChars


-- Convert a text case to lower characters
-- Note: Requires the translateChars function
-- todo conform to lib style
on lowerString(theText)
	set upper to "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	set lower to "abcdefghijklmnopqrstuvwxyz"
	return translateChars(theText, upper, lower)
end lowerString


-- Convert a text case to upper characters
-- Note: Requires the translateChars function
on upperString(theText)
	set lower to "abcdefghijklmnopqrstuvwxyz"
	set upper to "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	return translateChars(theText, lower, upper)
end upperString


-- Capitalize a text, returning only the first letter uppercased
-- Note: Requires translateChars, lowerString and upperString
on capitalizeString(theText)
	set firstChar to upperString(first character of theText)
	set otherChars to lowerString(characters 2 thru -1 of theText)
	return firstChar & otherChars
end capitalizeString


-- Trims the provided string from the text's beginning
-- Removes match_text from left in the @param the_text
on lstripString(theText, trimString)
	set x to count trimString
	try
		repeat while theText begins with the trimString
			set theText to characters (x + 1) thru -1 of theText as text
		end repeat
	on error
		return ""
	end try
	return theText
end lstripString
-- Trims the provided string from the text's ending
on rstripString(theText, trimString)
	set x to count trimString
	try
		repeat while theText ends with the trimString
			set theText to characters 1 thru -(x + 1) of theText as text
		end repeat
	on error
		return ""
	end try
	return theText
end rstripString

-- Trims the provided string from the text's boundaries
-- Note: Requires the lstripString and rstripString functions
on stripString(theText, trimString)
	set theText to lstripString(theText, trimString)
	set theText to rstripString(theText, trimString)
	return theText
end stripString