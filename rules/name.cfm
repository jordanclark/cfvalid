<cfif arguments.autoFix>
	<cfset LOCAL.value = trim( reReplace( LOCAL.value, "[^[:alpha:].', -]", "", "all" ) )>
</cfif>

<cfif NOT reFind( "^[[:alpha:]]+[[:alpha:]\.', -]*([[:alpha:]]|\.)$", LOCAL.value )>
	<cfset LOCAL.value = trim( reReplace( LOCAL.value, "[^[:alpha:].', -]", "", "all" ) )>
	<cfset LOCAL.error = "{label} should only contain valid letters, spaces and punctuations.">
</cfif>

