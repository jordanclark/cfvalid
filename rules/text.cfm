<cfif arguments.autoFix>
	<cfset LOCAL.value = reReplace( LOCAL.value, "[^[:print:]]", "", "all" )>
</cfif>

<cfif reFind( "[^[:print:]]", LOCAL.value )>
	<cfset LOCAL.value = reReplace( LOCAL.value, "[^[:print:]]", "", "all" )>
	<cfset LOCAL.error = "{label} can only contain normal printable characters.">
</cfif>

