(*
 * Assserts if theWord is in theString
 *)
on has_word(the_string, the_word)
	the_word is in (words of the_string)
end has_word
(*
 * you can also use "is equal to" instead of the equal sign, the opposite is "is not equal to"
 *)
on is_equal(a, b)
	return (a = b)
end is_equal
(*
 * Asserts if theText is of class text
 *)
on is_text(the_text)
	if class of the_text = text then
		return true
	else
		return false
	end if
end is_text