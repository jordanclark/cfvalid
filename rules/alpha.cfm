<cfif arguments.autoFix>
	<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^[:alpha:]]", "", "all" ) )>
</cfif>

<cfif reFindNoCase( "[^[:alpha:]]", LOCAL.value )>
	<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^[:alpha:]]", "", "all" ) )>
	<cfset LOCAL.error = "{label} can only contain letters (A-Z).">
</cfif>

