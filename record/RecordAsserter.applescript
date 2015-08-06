--Note: associative  arrays or as applescript likes to call them: records, can't be looped over, so instead you can use 2 dimensional array like so {{color:"004411"},{code:"FF0022"}} and access the values like so: first item of (item 2 of some_list) and second item of (item 2 of some_list)  etc
on is_in(the_record, the_item)
	return the_item is in _the_record
end is_in