<cfif arguments.mutable AND arguments.autoFix>
	<cfset LOCAL.value = trim( LOCAL.value )>
</cfif>

<cfif reFindNoCase( "[^[:alnum:]]", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^[:alnum:]]", "", "all" ) )>
	</cfif>
	<cfset LOCAL.error = "{label} can only contain letters (A-Z) and numbers (0-9).">
</cfif>

