--Note: All shell calls resets previouse shell variables, append with ";" after each shell command if you need to run many shell calls in a row
(*
 * Touch creates files	
 *)
on touch() --touch creates an index.html file
	set retMSG to do shell script "cd ~/test/" --touch ~/test/error.html
	log "retMSG: " & retMSG
end touch
