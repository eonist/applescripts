--Note: All shell calls resets previouse shell variables, append with ";" after each shell command if you need to run many shell calls in a row
--Note: Alot of FAQ's about Shell in applescript here: https://developer.apple.com/library/mac/technotes/tn2065/_index.html
(*
 * Touch creates files
 *)
on touch() --touch creates an index.html file
	set retMSG to do shell script "cd ~/test/" --touch ~/test/error.html
	log "retMSG: " & retMSG
end touch
(*
 * Removes file or folder
 * Param: the_name: name of file or folder
 * Param: posix_file_path: the path of the file or folder
 * Note: rm -rf ~/testing/.git
 *)
on remove(posix_file_path)
	do shell script "rm -rf " & posix_file_path
end remove
(*
 * Note: Instead of loading a .sh shell script into terminal, we compile it as a string and run it directly in terminal
 * Note: the upside of running the script directly as a string is that we dont have to include a .sh in every project
 * Note: When including shell scripts inside applescripts, be carefull with using linebreaks as "return" or end calls with ";" and avoid ending a line with &, use only & in none end places
 * Note Using a shell script file, returns the same result: log do shell script "cd ~/;" & "sh hexatoascii.sh x6162634028292F3132335F262F25242F26242325242226C2A7E2889E7CC2A7E2889E7"
 * Example: --log hex_to_ascii("x6162634028292F3132335F262F25242F26242325242226C2A7E2889E7CC2A7E2889E7")--abc@()/123_&/%$/&$#%$"&��|��
 * Caution: seems to work without the x infront of the hex aswell, 0x00FF00 format doesnt seem to work
 *)
on hex_to_ascii(the_hex_text)
	set the_shell_script to "#!/bin/bash
		string=`echo " & the_hex_text & " | tr -d \\x`
		i=1
		max=$(( ${#string} + 1 ))
		while [ $i -lt $max ]
		do
        		hex='\\x'`echo $string | cut -c $i-$(( i + 1 ))`
       	 	strhex=$strhex$hex
       		i=$(( i + 2 ))
		done
		printf $strhex" #was echo -e, but printf returns a the ascci text without the -e chars infront of it, one les thing to take care of
	--log the_shell_script
	return do shell script the_shell_script
end hex_to_ascii
(*
 * Delays 5 secs, then checks for internet, if it doesnt have internet, the process is repeated
 * NOTE: Just add a call to this method when you need to check for internet
 *)
on wait_for_internet()
  repeat while has_internet_connection()
    log "no internet connection"
    delay 5--delays 5 seconds
  end repeat
  log "has internet connection"
end wait_for_internet
(*
 * --comment here
 *)
on has_internet_connection()
	return (do shell script "ping -c 1 www.apple.com") contains "100% packet loss"--0.0% packet loss is the opposite 
end has_internet_connection
