--Logs all items in a list
on log_items(the_list)
	repeat with i from 1 to (length of the_list)
		set theItem to item i of the_list
		log theItem
	end repeat
end log_items
--TODO add support for returning a value when there is no index, maybe 0 maybe -1 maybe even null
--Returns the index of an item in a list
on index_of(array, theItem)
	repeat with i from 1 to (length of array)
		if theItem = (item i of array) then
			return i
		end if
	end repeat
	return null
end index_of
--Returns the indices of multiple items in a list
on indices(the_list, the_items)
	set the_indices to {}
	repeat with i from 1 to (length of the_items)
		set the_item to item i of the_items
		--log the_item
		set the_indices to the_indices & index_of(the_list, the_item)
	end repeat
	return the_indices
end indices
--Clones a list
on clone(the_list)
	return every item of the_list
end clone
--TODO possibly rename to "all()"
--Retuns an array of items at specific indices {blue,red,pink},{1,2} returns red and pink etc
--@indices: a list comprised of integeres
--@the_list: an array of items
on items_at(the_list, indices)
	set the_items to {}
	repeat with i from 1 to (length of indices)
		set the_index to item i of indices
		set the_items to the_items & (item the_index of the_list)
	end repeat
	return the_items
end items_at
