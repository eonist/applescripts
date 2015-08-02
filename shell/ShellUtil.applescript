(*
 * Touch creates files	
 *)
on touch() --touch creates an index.html file
	set retMSG to do shell script "cd ~/test/" --touch ~/test/error.html
	log "retMSG: " & retMSG
end touch

(*
 * Retrive passwords from Apples keychain application by querrying the keychain item name
 * Note: Make sure you set the keychain item to allow this script to retrive passwords
 * Example: keychain_password("flowerpower")--"abc123"
 *)
on keychain_password(keychain_item_name)
	do shell script "security 2>&1 >/dev/null find-generic-password -gl " & quoted form of keychain_item_name & " | awk '{print $2}'"
	return (text 2 thru -2 of result)
end keychain_password