<cfif arguments.mutable AND arguments.autoFix>
	<cfset LOCAL.value = trim( LOCAL.value )>
</cfif>

<cfif reFindNoCase( "[^A-Z_]", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^A-Z_]", "", "all" ) )>
	</cfif>
	<cfset LOCAL.error = "{label} can only contain letters (A-Z) and underscore.">
</cfif>

