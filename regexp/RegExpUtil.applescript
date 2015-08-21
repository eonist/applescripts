--property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
--property RegExpUtil : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "regexp:RegExpUtil.applescript"))

(*
 * Matches string s against regular expression (string) regex using bash's extended regular expression language *including* 
 * Note: sed regexp does not support lookahead, lookbehind, lazy quantifieres, so use groups or nested regexp calls may be needed in order to get at the bits you want
 * Note: support for shortcut classes such as `\d`, and assertions such as `\b`, and *returns a Boolean* to indicate if there is a match or not.
 * Note: AppleScript's case sensitivity setting is respected; i.e., matching is case-INsensitive by default, unless inside a 'considering case' block.
 * Note: The current user's locale is respected.
 * Note: lots of sed examples: http://www.grymoire.com/Unix/Sed.html#uh-3
 * Note: There is an easier way to make use of the shell (works on bash 3.2+) for regex matching:
 * set isMatch to "0" = (do shell script "[[ " & quoted form of fileName & " =~ ^[[:digit:]]{10} ]]; printf $?")
 * Example: my doesMatch("127.0.0.1", "^(\\d{1,3}\\.){3}\\d{1,3}$") # -> true
 * Example: doesMatch(text, regexString) -> Boolean
 *)
on has_match(s, regex) --// :TODO: rename s to string
	local ignoreCase, extraGrepOption
	set ignoreCase to "a" is "A"
	if ignoreCase then
		set extraGrepOption to "i"
	else
		set extraGrepOption to ""
	end if
	(* 
	 * Note: So that classes such as \w work with different locales, we need to set the shell's locale explicitly to the current user's.
	 * Rather than let the shell command fail we return the exit code and test for "0" to avoid having to deal with exception handling in AppleScript.
	 *)
	tell me to return "0" = (do shell script "export LANG='" & user locale of (system info) & ".UTF-8'; egrep -q" & extraGrepOption & " " & quoted form of regex & " <<< " & quoted form of s & "; printf $?")
end has_match
(*
 * Matches string s against regular expression (string) regex using bash's extended regular expression language and
 * returns the matching string and substrings matching capture groups, if any.*
 * Example: getMatch(text, regexString) -> { overallMatch[, captureGroup1Match ...] } or {}
 * Example: my getMatch("127.0.0.1", "^([[:digit:]]{1,3})\\.([[:digit:]]{1,3})\\.([[:digit:]]{1,3})\\.([[:digit:]]{1,3})$") # -> { "127.0.0.1", "127", "0", "0", "1" }
 * Example: set the_result to RegExpUtil's match("abc 123", "^([a-z]+)[[:space:]]([1-9]+)$")--(*abc 123, abc, 123*)--length of the_result--(*3*)
 * Note: AppleScript's case sensitivity setting is respected; i.e., matching is case-INsensitive by default, unless this subroutine is called inside a 'considering case' block.
 * Note: The current user's locale is respected.
 * Note: Also, `\b`, '\B', '\<', and '\>' are not supported; you can use `[[:<:]]` for '\<' and `[[:>:]]` for `\>`
 * Note: Always returns a *list*: an empty list, if no match is found, otherwise, the first list element contains the matching string
 * Note: if regex contains capture groups, additional elements return the strings captured by the capture groups; note that *named* capture groups are NOT supported.
 * Note: if the text contains linebreaks these must be replaced with spaces, since the return value is a list, and text with linebreaks are also considered a list. 
 * Note: if you need to preserve linebreaks in your result then you may replace linebreaks with a placeholder set of characters that you then replace qith linebreaks after the match is done
 * Important: Unlike doesMatch(), this subroutine does NOT support shortcut character classes such as \d. Instead, use one of the following POSIX classes (see `man re_format`):
 * [[:alpha:]] [[:word:]] [[:lower:]] [[:upper:]] [[:ascii:]]
 * [[:alnum:]] [[:digit:]] [[:xdigit:]]
 * [[:blank:]] [[:space:]] [[:punct:]] [[:cntrl:]] 
 * [[:graph:]]  [[:print:]] 
 * Description:
 * [:alpha:] the Roman letters
 * [:lower:] the lowercase Roman letters
 * [:upper:] the uppercase Roman letters
 * [:digit:] the digits
 * [:xdigit:] the hexadecimal digits (lowercase and uppercase)
 * [:blank:] space or tab
 * [:space:] space, tab, CR, LF or FF
 * [:cntrl:] the set of the characters with an ASCII code < 32 or = 127
 * [:punct:] neither a control character nor alphanumeric
 * Since \w \W etc doest work we must use:
 * [a-z]- any lowercase character
 * [a-z0-9] any lowercase character or numbers
 * [A-z] any character ([a-zA-Z] also works)
 * [a-zA-z0-9_] any character or number - equivalent to \w
 * [A-z0-9_] any character or number - equivalent to \w 
 *)
on match(s, regex) --// :TODO: rename s to string
	local ignoreCase, extraCommand
	set ignoreCase to "a" is "A"
	if ignoreCase then
		set extraCommand to "shopt -s nocasematch; "
	else
		set extraCommand to ""
	end if
	(* Note: 
	 * So that classes such as [[:alpha:]] work with different locales, we need to set the shell's locale explicitly to the current user's.
	 * Since `quoted form of` encloses its argument in single quotes, we must set compatibility option `shopt -s compat31` for the =~ operator to work.
	 * Rather than let the shell command fail we return '' in case of non-match to avoid having to deal with exception handling in AppleScript.
    *)
	tell me to do shell script "export LANG='" & user locale of (system info) & ".UTF-8'; shopt -s compat31; " & extraCommand & "[[ " & quoted form of s & " =~ " & quoted form of regex & " ]] && printf '%s\\n' \"${BASH_REMATCH[@]}\" || printf ''"
	return paragraphs of result --paragraphs returns a list, which can be unconvenient 
end match

(*
 * Todo: untested
 *)
on match_and_replace(the_text)
	set the_result to do shell script "echo " & quoted form of the_text & " | sed 's/ /\\\\ /g'"
	return the_result
end match_and_replace
(*
Note:

Makes use of a modern bash test expression [[ ... ]] with the regex-matching operator, =~; not quoting the right operand (or at least the special regex chars.) is a must on bash 3.2+, unless you prepend shopt -s compat31;
The do shell script statement executes the test and returns its exit command via an additional command (thanks, @LauriRanta); "0" indicates success.
Note that the =~ operator does not support shortcut character classes such as \d and assertions such as \b (true as of OS X 10.9.4 - this is unlikely to change anytime soon).
For case-INsensitive matching, prepend the command string with shopt -s nocasematch;
For locale-awareness, prepend the command string with export LANG='" & user locale of (system info) & ".UTF-8';.
If the regex contains capture groups, you can access the captured strings via the built-in ${BASH_REMATCH[@]} array variable.
As in the accepted answer, you'll have to \-escape double quotes and backslashes.
Here's an alternative using egrep:

set isMatch to "0" = (do shell script Â
  "egrep -q '^\\d{10}' <<<" & quoted form of filename & "; printf $?")
Though this presumably performs worse, it has two advantages:

You can use shortcut character classes such as \d and assertions such as \b
You can more easily make matching case-INsensitive by calling egrep with -i:
You canNOT, however, gain access to sub-matches via capture-groups; use the [[ ... =~ ... ]] approach if that is needed.
Finally, here are utility functions that package both approaches (the syntax highlighting is off, but they do work):
*)
