(*
 * Note: to log the return value you must create an if statment that asserts the boolean value returned, short hand if statment should work
 *)
on equals_to(a, b)
	return a = b
end equals_to
(*
 * {1,2,3,4} contains 3--true
 * Note: to log the return value you must create an if statment that asserts the boolean value returned, short hand if statment should work
 *)
on contains_List(a, b)
	a contains b
end contains_List
--Add these to this class:
-- add {1, 2, 3, 4} starts with {1}
-- add {1, 2, 3, 4} ends with {3, 4}
-- add {1, 2} is in {1, 2, 3}--true
