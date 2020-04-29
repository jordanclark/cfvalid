<cfif arguments.autoFix>
	<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^A-Z_]", "", "all" ) )>
</cfif>

<cfif reFindNoCase( "[^A-Z_]", LOCAL.value )>
	<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^A-Z_]", "", "all" ) )>
	<cfset LOCAL.error = "{label} can only contain letters (A-Z) and underscore.">
</cfif>

