<cfif arguments.autoFix>
	<cfset LOCAL.value = reReplace( LOCAL.value, "[^[:digit:]]", "", "all" )>
</cfif>

<cfif NOT isNumeric( LOCAL.value ) OR reFindNoCase( "[^[:digit:]]", LOCAL.value )>
	<cfset LOCAL.value = reReplace( LOCAL.value, "[^[:digit:]]", "", "all" )>
	<cfset LOCAL.error = "{label} can only contain numbers (0-9).">
</cfif>
