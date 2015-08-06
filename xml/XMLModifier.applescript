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
--attributes contain a list with "sudo accociative lists" like {{"key","color"},{"code","FF0503"}}
on element_with_attribute(the_name, the_content, the_attributes)
	set attribute_text to ""
	repeat with i from 1 to (length of the_attributes)
		set attribute to item i of the_attributes
		set the_key to first item in attribute
		set the_value to (second item in attribute)
		set attribute_text to attribute_text & (the_key & "=" & "\"" & the_value & "\"")
		if attribute is not the last item in the_attributes then set attribute_text to attribute_text & " " --append a space after each key value pair, unless its at the end
		
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