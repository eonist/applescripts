property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property RegExpUtil : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "regexp:RegExpUtil.applescript"))
(*
 * Example: is_year("2015")--true
 *)
on is_year(the_text)
	set the_pattern to "[[:digit:]]{4}"
	return RegExpUtil's has_match(the_text, the_pattern)
end is_year
(*
 * OSX sed doesnt seem to support wod boundaies, google may have information on workarounds
 *)

on isloated_word(the_text)
	set the_pattern to ""
	return RegExpUtil's match(the_text, the_pattern)
end isloated_word

--log not_char("abc dfg")
--finds text without the char a
--log RegExpUtil's match(" bla bla \"thePassWord\" jada jasa", "\"([^\"]+)\"")--(*"thePassWord", thePassWord*)
on not_char(the_text)
	set the_pattern to "[^a]+"
	return RegExpUtil's match(the_text, the_pattern)
end not_char

