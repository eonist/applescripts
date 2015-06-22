--Returns the value of xmlItem (XML item)
--remeber to cast the returned value to the excpected type (i.e: as string)
on xml_value(xml_item)
	tell application "System Events"
		return value of xml_item
	end tell
end xml_value
--Returns the name of xmlItem (XML item)
on xml_name(xml_item)
	return name of xml_item
end xml_name
--Returns an XML item
on element_at(xml_item, the_index)
	tell application "System Events"
		return XML element the_index of xml_item
	end tell
end element_at
--Returns an XML item attribute at index (use name of, value of)
--Remember to use attributeValue() to obrain the value
on attribute_at(xml_item, the_index)
	tell application "System Events"
		return XML attribute the_index of xml_item
	end tell
end attribute_at
--Returns the value of the attribute at index
on attribute_value_at(xml_item, the_index)
	set attr to attribute_at(xml_item, the_index) --the_index was 1
	return attributeValue(attr)
end attribute_value_at
--Returns the value of the first element that has the name of theName
--TODO possibly move to AdvanceXMLParser
on element(xml_data, the_name)
	tell application "System Events"
		repeat with i from 1 to count of XML elements of xml_data
			set e_name to (get name of XML element i of xml_data) as Unicode text
			if e_name is equal to the_name then
				--display dialog "found a match"
				return value of XML element i of xml_data
			else
				my element(XML element i of xml_data, the_name)
			end if --bug fix
		end repeat
	end tell
end element
--Returns an element by attribute (key and value pair)
on element_by_attribute(xml_data, attr_key, attr_val)
	tell application "System Events"
		repeat with i from 1 to count of XML elements of xml_data
			set elm to XML element i in xml_data
			set val to my attribute_value_by_name(elm, attr_key)
			if val = (attr_val as string) then
				return elm
			end if
		end repeat
		return missing value
	end tell
end element_by_attribute
--Returns the first attribute with theName
--retrive name and value from the attribute, remember to cast as string
--TODO rename to attributeByKey?!?
on attribute_by_name(xml_data, the_name)
	tell application "System Events"
		return first XML attribute of xml_data whose name is the_name
	end tell
end attribute_by_name
--returns the root of the xml
on root(xml_file)
	tell application "System Events"
		set xml_data to contents of XML file xml_file
		return XML element 1 of xml_data
	end tell
end root
--Returns every XML element in xmlElement
on every_element(xml_element)
	tell application "System Events"
		return every XML element of xml_element
	end tell
end every_element
--Returns the value of the first attribute with attributeName
--Consider renaming to attributeValueByKey
on attribute_value_by_name(xml_element, attribute_name)
	--log ("attributeName" & attributeName)
	set attr to attribute_by_name(xml_element, attribute_name)
	--log (theAttribute)
	return attribute_value(attr)
end attribute_value_by_name
--Returns a value of an attribute
on attribute_value(the_attribute)
	tell application "System Events"
		return value of the_attribute
	end tell
end attribute_value