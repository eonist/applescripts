(*
 * Touch creates files	
 *)
on touch() --touch creates an index.html file
	set retMSG to do shell script "cd ~/test/" --touch ~/test/error.html
	log "retMSG: " & retMSG
end touch
--log keychain_password("flowerpower")
set t to do shell script "security 2>&1 find-generic-password -gl " & "flowerpower"
log t