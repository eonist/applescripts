property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property RegExpUtil : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "regexp:RegExpUtil.applescript"))
property TextParser : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "text:TextParser.applescript"))
property ShellUtil : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "shell:ShellUtil.applescript"))

(*
 * Returns a record with account name and password by querrying keychain with the "keychain item name" of the password-keychain-item
 * Note: the_keychain_item_name is the "name" of the keychain-password-item
 * Caution: Make sure your keychain item is unique, or else it may return the wrong keychain, this includes secure notes
 * Note: appending find-generic-password -a  & account_name &  -g will retrive keychain itm name and pass from account name
 * Example: keychain_data("flowerpower2")--{keychain_item_name:"flowerpower2", account_name:"John", the_password:"HereIsJohnny2015"}
 * Note: to access a record use the_password of keychain_data
 * Todo: impliment support for retriving the comment in the keychain item
 * Caution: If there are unusual characters in the password, it isn't output as plain text, it's output encoded in hex. Here's a python script I've been using which covers that case: http://blog.macromates.com/2006/keychain-access-from-shell/
 * Caution: If the password contains special chars, the password will be returned as hex values, Use ShellUtil's hex_to_ascii(hex_text
 *)
on keychain_data(the_keychain_item_name)
	log "keychain_data()"
	set pass_result to (do shell script "2>&1 security find-generic-password -gl " & the_keychain_item_name) --outputs pass and login credentials
	log pass_result
	log length of pass_result
	
	set wrapped_text to TextParser's wrap_text(pass_result, " ") --wraps the text into one line, replaces linebreaks with a single space char
	log "wrapped_text: " & wrapped_text
	
	set pattern to "password\\: (.+) keychain\\: \"([a-z0-9/.]+)\" version\\: ([0-9]+) class\\: \"genp\" attributes\\:(.+)" --old pattern: "password\\: (.+) keychain\\: \"([a-z0-9/.]+)\" class\\: \"genp\" attributes\\:(.+)"
	set the_result to RegExpUtil's match(wrapped_text, pattern)
	log "the_result: " & the_result
	
	--continue here, the regexp doesnt work, thats it!
	
	
	log "length of result: " & (length of the_result)
	log second item in the_result
	
	log "third"
	
	log third item in the_result
	log fourth item in the_result
	log fifth item in the_result
	log ">"
	set the_password_text to (second item in the_result)
	log "<"
	log "the_password_text: " & the_password_text
	set password_result to RegExpUtil's match(the_password_text, "0?x?([0-9A-F]+)?[[:space:]]*\"(.+)\"")
	
	if (second item in password_result = "") then --is string-form
		set the_password to third item in password_result
	else --is hex-form
		set hex_pass to second item in password_result
		log "hex_pass: " & hex_pass
		set the_password to ShellUtil's hex_to_ascii(hex_pass)
	end if
	log "the_password: " & the_password
	set the_content to fifth item in the_result --was fourth but apple changed their keychain api in osx 10.11.6
	log the_content
	set account_name_result to RegExpUtil's match(the_content, " \"acct\"\\<blob\\>\\=\"([^\"]+)\"")
	log account_name_result
	log length of account_name_result
	log first item in account_name_result
	set account_name to second item in account_name_result
	log "account_name:" & account_name
	return {account_name:account_name, the_password:the_password}
end keychain_data

--keychain_password("flowerpower") --"abc123"
(*
 * Retrive passwords from Apples keychain application by querrying the keychain item name (not account name)
 * Note: Make sure you set the keychain item to allow this script to retrive passwords
 * Example: keychain_password("flowerpower")--"abc123"
 * Caution: If the password contains special chars, the password will be returned as hex values, Use ShellUtil's hex_to_ascii(hex_text)
 *)
on keychain_password(keychain_item_name)
	set the_result to do shell script "security 2>&1 >/dev/null find-generic-password -gl " & quoted form of keychain_item_name & " | awk '{print $2}'"
	--log the_result
	return (text 2 thru -2 of the_result)
end keychain_password

--to add a keychain: security add-generic-password -s google -a mogensen -w PaSSW0rd

--internet pass: security find-internet-password -g -s www.google.com 
--PASSWORD=`security find-internet-password -wl "KUPHOG-NAS"`


on keychain_account()
	--Todo: complete me
end keychain_account

