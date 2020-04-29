<cfif arguments.autoFix>
	<cfset LOCAL.value = reReplace( uCase( LOCAL.value ), "[^A-F0-9]+", "", "all" )>
</cfif>

<cfif reFindNoCase( "[^[A-F0-9]]", LOCAL.value )>
	<cfset LOCAL.value = reReplace( uCase( LOCAL.value ), "[^A-F0-9]+", "", "all" )>
	<cfset LOCAL.error = "{label} can only contain numbers (0-9) and letters (A-F).">
</cfif>

