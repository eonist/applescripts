--Note: All shell calls resets previouse shell variables, append with ";" after each shell command if you need to run many shell calls in a row
(*
 * Touch creates files	
 *)
on touch() --touch creates an index.html file
	set retMSG to do shell script "cd ~/test/" --touch ~/test/error.html
	log "retMSG: " & retMSG
end touch

log hex_to_ascii("x6162634028292F3132335F262F25242F26242325242226C2A7E2889E7CC2A7E2889E7") --abc@()/123_&/%$/&$#%$"&ぐ|ぐ

(*
 * Note: Instead of loading a .sh shell script into terminal, we compile it as a string and run it directly in terminal
 * Note: the upside of running the script directly as a string is that we dont have to include a .sh in every project
 * Note: When including shell scripts inside applescripts, becarefull with using linebreaks as "return" or end calls with ";"
 * Note Using a shell script file, returns the same result: log do shell script "cd ~/;" & "sh hexatoascii.sh x6162634028292F3132335F262F25242F26242325242226C2A7E2889E7CC2A7E2889E7"
 * Example: --log hex_to_ascii("x6162634028292F3132335F262F25242F26242325242226C2A7E2889E7CC2A7E2889E7")--abc@()/123_&/%$/&$#%$"&ぐ|ぐ
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