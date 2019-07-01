<cfif arguments.mutable AND arguments.autoFix>
	<cfset LOCAL.value = trim( LOCAL.value )>
</cfif>

<cfif reFindNoCase( "[^[:alpha:]]", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^[:alpha:]]", "", "all" ) )>
	</cfif>
	<cfset LOCAL.error = "{label} can only contain letters (A-Z).">
</cfif>

