<cfif arguments.autoFix>
	<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^[:alnum:]]", "", "all" ) )>
</cfif>

<cfif reFindNoCase( "[^[:alnum:]]", LOCAL.value )>
	<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^[:alnum:]]", "", "all" ) )>
	<cfset LOCAL.error = "{label} can only contain letters (A-Z) and numbers (0-9).">
</cfif>

