(*
 * Returns xml header
 *)
on header()
	return "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
end header
(*
 * Returns an XML item with name and content
 * Todo: impliment no content = single element
 *)
on element(the_name, content)
	set xml_text to "<" & the_name
	if (length of the_content > 0) then --has content
		set xml_text to xml_text & ">" & content & "</" & the_name & ">" --end of xml text
	else --no content
		set xml_text to xml_text & "/>" --end of xml text
	end if
	return "<" & the_name & ">" & content & "</" & the_name & ">"
end element
--no content = single element
--attributes contain a list with accociative lists like {key:"color",code:"FF0503"}
on element_with_attribute(the_name, the_content, the_attributes)
	set attribute_text to ""
	repeat with attribute in the_attributes
		set attribute_text to attribute_text & ((key of attribute) & "=" & "\"" & (value of attribute) & "\"")
	end repeat
	set xml_text to "<" & the_name & " " & attribute_text --beginning of xml text
	if (length of the_content > 0) then --has content
		set xml_text to xml_text & ">" & the_content & "</" & the_name & ">" --end of xml text
	else --no content
		set xml_text to xml_text & "/>" --end of xml text
	end if
	return xml_text
end element_with_attribute
--
on element_beginning(the_name)
	return "<" & the_name & ">"
end element_beginning
--
on element_end(the_name)
	return "</" & the_name & ">"
end element_end