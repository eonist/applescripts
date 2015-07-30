(*
 * Returns an array of every word in the_text
 *)
on every_word(the_text)
	return every word of the_text
end every_word
(*
 * Returns all paragraps in a text as a list
 * TODO: write an example
 *)
on every_paragraph(the_text)
	set paragraph_list to {}
	set para_list to paragraphs of the_text
	repeat with next_line in para_list
		if length of next_line is greater than 0 then -- this takes care of not adding an emty item at the end
			copy next_line to the end of paragraph_list
		end if
	end repeat
	return paragraph_list
end every_paragraph
(*
 * Returns a list of text items by splitting a text at every delimiter
 *)
on split(the_text, delimiter)
	set text item delimiters to delimiter
	set ret_val to every text item of the_text
	set text item delimiters to "," --reset applescript delimiter to default
	return ret_val
end split
(*
 * Returns the length of theText
 *)
on text_length(the_text)
	return length of the_text
end text_length
(*
 * Returns a comma delimited list like "blue, red, orange" from an array like {"blue","red","orange"}
 * Example: log TextParser's comma_delimited_text({"blue", "red", "orange"}) yields "blue, red, orange"
 * TODO USE THIS INSTEAD: set AppleScript's text item delimiters to {" "} -- A single space
 * TODO move to ArrayParser
 * AND THEN : the_list as text
 *)
on comma_delimited_text(text_items)
	delimited_text(text_items, "," & space)
end comma_delimited_text
--Returns a text item by stitching many text items together with the delimiter inbetween each word
on delimited_text(text_items, delimiter)
	set ret_val to ""
	repeat with i from 1 to (length of text_items)
		set the_word to item i of text_items
		set head to ""
		set tail to delimiter
		if i = 1 then
			set head to ""
		end if
		if i = (length of text_items) then
			set tail to ""
		end if
		set ret_val to ret_val & head & the_word & tail
	end repeat
	return ret_val
end delimited_text
(*
 * TODO: doesnt this add a return at the last line? maybe use delimited_text() intead? 
 *)
on to_paragraphs(the_list)
	set AppleScript's text item delimiters to {return}
	return the_list as text
end to_paragraphs
(*
 * cardinal is one two three etc
 * TODO: one could create a dynamic ordinal generator in the future, that would combine two words to generate twenthy+eigth etc
 *)
on ordinal(the_number)
	set ordinals to {"first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth", "thirteenth", "fourteenth", "seventeenth", "eigthteenth", "nineteenth", "twenteenth"}
	return item the_number of ordinals
end ordinal
(*
 * Returns encode text (escaped)
 * Note: this could also be done by creating a a method that does all the character trickery involved in unescaping/escaping text, but this method leverages the php language to do all this for us
 * Example: encode("<image location:files/img/image.jpg")--%3Cimage+location%3Afiles%2Fimg%2Fimage.jpg
 *)
on encode(the_text)
	return do shell script "php -r 'echo urlencode(\"" & the_text & "\");'"
end encode
(*
 * Returns dencode text (unescaped)
 * Note this could also be done by creating a a method that does all the character trickery involved in unescaping/escaping text, but this method leverages the php language to do all this for us
 * Example: decode(%3Cimage+location%3Afiles%2Fimg%2Fimage.jpg)--<image location:files/img/image.jpg
 *)
on decode(the_text)
	return do shell script "php -r 'echo urldecode(\"" & the_text & "\");'"
end decode
(*
 * Returns a text in quoted form
 *)
on quoted_form(the_text)
	return quoted form of the_text
end quoted_form
(*
 * substring
 * the start: 1
 * the end: ((length of second_part) - 2)
 * Todo: write an example
 *)
on sub_string(the_start, the_end, the_text)
	return text the_start thru the_end of the_text
end sub_string

-- Counts how many times a string appears in a text
-- Note: Its splits the text by the substring and count the items
--
on countSubstring(theText, theSubstring)
   set AppleScript's text item delimiters to theSubstring
   set counter to (count of every text item of theText) - 1
   set AppleScript's text item delimiters to ""
   return counter
end countSubstring
