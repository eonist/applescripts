

-- ShellScripting Keychains
-- BP Aug, 2011

-- Permits AppleScript access to keychain items through BSD's 'security' command.
-- Run this script to demonstrate its main functions.

-- If you'd rather use a separate App for scripting the keychain, try
-- http://www.red-sweater.com/blog/2035/usable-keychain-scripting-for-lion

-----------------------------------------------------------------------------------------------------
(*
A little terminological clarification:
What Keychain Access calls a 'Name', the security utility calls a 'label' (-l is match label string)
What Keychain Access calls an 'Account', the security utility calls a 'name' (-a is "match account name string")
What Keychain Access calls 'Where', the security utility calls a 'service name' (-s is "match service name string")
*)
-----------------------------------------------------------------------------------------------------
set t to "" -- all purpose variable holds various types of data

tell application "Keychain Access" to activate -- Bring this up so as to see what's happening in the keychain.
tell application "Script Editor" to activate

set label to "My New Keyitem" --e        -- if omitted, service name is used as default label
set KeyKind to "application password" --e unless new type is "Internet password", then --n
-- set KeyKind to "Internet password" --e -- here for testing internet password items
set AcctName to "Vladimir's Secret Cache" -- n
set ServiceName to "Boise Oblast dot com" --n
set Acctpassword to "tootyfruity232" --e
set AcctComments to "Chatty stuff of no import, except to the chatterer. Or someone could fill this space with a pointer to another keychain entry." --e
(*
Trying to add an item to the keychain twice usually results in an error (indicated by --e above).
Changing AcctName, ServiceName or KeyKind to "Internet password" produces a 2nd keychain item (indicated by --n above).. 
The security add-XX-password command's -U (for update) option alters this behavior.
*)


set t to AddPwrdItemToKeychain(label, KeyKind, AcctName, ServiceName, Acctpassword, AcctComments) -- Add a new password item to the default keychain 

-- set t to GetPassword(label, KeyKind) -- ********** If you just want a password, this line will do nicely **********

set t to GetAcctnameServicenameAndPwrdFromPwrdItem(label, KeyKind) -- Read and display data from that new password item

-- Show the results in a Dialog, and let user DELETE the keychain entry if desired.
set t2 to "Label: 			" & label & "
" & "Account name: 	" & text item 1 of t & "
" & "Password: 		" & text item 2 of t & "
" & "Service name: 	" & text item 3 of t & "
"
set dr to display dialog t2 buttons {"Delete Item", "OK"} default button 2 with title "Recovered Keychain Item Data"
if button returned of dr is equal to "Delete Item" then
	set t to DeletePwrdItemFromKeychain(label, KeyKind) -- Delete the newly added password item from the keychain.
end if

return t -- look to the result pane

-----
-----
on AddPwrdItemToKeychain(label, KeyKind, AcctName, ServiceName, Acctpassword, AcctComments)
	-- Make UNIX happy by quoting everything:
	set Qlabel to quoted form of label
	set QKeyKind to quoted form of KeyKind
	set QAcctName to quoted form of AcctName
	set QServiceName to quoted form of ServiceName -- or server if it's an internet password being created
	set QAcctpassword to quoted form of Acctpassword
	set QAcctComments to quoted form of AcctComments
	
	set retval to true
	
	-- Unless specified, new items are added to the default, usually login, keychain.
	-- add-generic-password [-h] [-a account] [-s service] [-w password] [options...] [keychain]
	-- add-internet-password [-h] [-a account] [-s server] [-w password] [options...] [keychain]
	try
		if KeyKind is equal to "Internet password" then
			set t to do shell script "security add-internet-password -a " & QAcctName & " -s " & QServiceName & " -w " & QAcctpassword & " -l " & Qlabel & " -j " & QAcctComments
		else
			set t to do shell script "security add-generic-password -a " & QAcctName & " -s " & QServiceName & " -w " & QAcctpassword & " -l " & Qlabel & " -j " & QAcctComments
		end if
	on error n --number n
		display dialog n buttons {"OK"} default button 1 with title "Key Creation Error" with icon caution -- error number 45 is keychain entry already exists.
		set retval to false
	end try
	return retval
end AddPwrdItemToKeychain

-----
-----
on GetAcctnameServicenameAndPwrdFromPwrdItem(label, KeyKind)
	set retarray to {"", "", ""}
	set Qlabel to quoted form of label
	set oldelim to text item delimiters
	
	try
		if KeyKind is equal to "Internet password" then
			set t to do shell script "security 2>&1 find-internet-password -gl " & Qlabel
		else
			set t to do shell script "security 2>&1 find-generic-password -gl " & Qlabel
		end if
		(* 
        That odd 2>&1 redirects password output from stderr to stdout so we can get to it along with everything else.
        See Allan Odgaard's posting here:
        http://blog.macromates.com/2006/keychain-access-from-shell/
        *)
		
		--display dialog t            -- Display raw data
		(* 
           Output is messy, and needs to be parsed.
           grep and friends could work here.
           See http://www.maclovin.de/2010/02/access-os-x-keychain-from-terminal/
           I'd rather use Applescript's text item delimiters here:
       *)
		set text item delimiters to "acct" -- Get Account name
		set tlst to every text item of t
		set acct to item 2 of tlst
		set text item delimiters to "\""
		set tlst to every text item of acct
		set acct to item 3 of tlst
		
		if KeyKind is equal to "Internet password" then -- Get Service name or Server
			set text item delimiters to "srvr" -- server
		else
			set text item delimiters to "svce" -- service
		end if
		set tlst to every text item of t
		set svcnam to item 2 of tlst
		set text item delimiters to "\""
		set tlst to every text item of svcnam
		set svcnam to item 3 of tlst
		
		set text item delimiters to "\"" -- Get Password
		set tlst to every text item of t
		set pw to item 2 of tlst
		--display dialog pw
		
		set retarray to {acct, pw, svcnam}
	on error
		display dialog "Sorry, can't find your keychain item." buttons "OK" default button 1 with icon caution
		set retarray to {"", "", ""}
	end try
	
	set text item delimiters to oldelim
	return retarray
end GetAcctnameServicenameAndPwrdFromPwrdItem
-----
-----
on DeletePwrdItemFromKeychain(label, KeyKind)
	set Qlabel to quoted form of label
	set retval to true
	
	try
		if KeyKind is equal to "Internet password" then
			set t to do shell script "security delete-internet-password -l " & Qlabel
		else
			set t to do shell script "security delete-generic-password -l " & Qlabel
		end if
	on error
		set retval to false
	end try
	
	return retval
end DeletePwrdItemFromKeychain
-----
-----
on LockDefaultKeychain()
	do shell script "security lock-keychain"
	
	-- This'll work too:
	-- do shell script "security lock-keychain login.keychain"    
end LockDefaultKeychain
-----
-----
on UnlockDefaultKeychain()
	-- KeychainAccess'll ask for password as needed, or I could hardcode it here.
	do shell script "security unlock-keychain"
end UnlockDefaultKeychain
-----
-----
on listKeychains()
	set t to do shell script "security list-keychains"
	display dialog t as text buttons "OK" default button 1 with title "Keychains List" -- Ugly but this is just a utility function
end listKeychains
-----
-----
on GetPassword(label, KeyKind)
	set Qlabel to quoted form of label
	(*
   I search keychains based on the desired item's label (ie what Keychain Access calls a name) here.
   An item's label appears to be its most unique identifier in a keychain. This is important because the find-XX-password
   command returns only the first matching instance.
   I could as easily search by other attributes, or combinations thereof: 

-a account Match account string
-c creator Match creator (four-character code)
-C type Match type (four-character code)
-D kind Match kind string
-G value Match value string (generic attribute)
-j comment Match comment string
-l label Match label string
-s service Match service string
-g Display the password for the item found        -- from the man page
   
           For example: set pwrd to do shell script "security 2>&1 >/dev/null find-generic-password -gs " & 'Boise Oblast dot com'
   *)
	
	try
		if KeyKind is equal to "Internet password" then
			set pwrd to do shell script "security 2>&1 >/dev/null find-internet-password -gl " & Qlabel
		else
			set pwrd to do shell script "security 2>&1 >/dev/null find-generic-password -gl " & Qlabel
		end if
		(* 
        That odd 2>&1 redirects password output from stderr to stdout so we can get to it.
        The >/dev/null redirects stdout, (everything except password) to nowhere.
        See Allan Odgaard's posting here:
        http://blog.macromates.com/2006/keychain-access-from-shell/
        *)
	on error
		set pwrd to ""
	end try
	
	--display dialog pwrd -- Display raw data This'll be something like "password: tuttyfruity"    
	
	set oldelim to text item delimiters -- clean up the extra text.
	set text item delimiters to "\""
	set tlst to every text item of pwrd
	set pwrd to item 2 of tlst
	set text item delimiters to oldelim
	
	--display dialog pwrd -- Display cleaned up data This'll be something like "tuttyfruity"
	
	return pwrd
end GetPassword
-----
-----
