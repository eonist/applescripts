(*
 * Returns xml header
 *)
on header()
	return "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
end header
(*
 * Returns an XML item with name and content
 *)
on element(the_name, content)
	return "<" & the_name & ">" & content & "</" & the_name & ">"
end element