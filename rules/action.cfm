<cfif arguments.mutable AND arguments.autoFix>
	<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^a-z0-9.-]", "", "all" ) )>
</cfif>

<cfif NOT reFindNoCase( "^[a-z0-9.-]+$", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^a-z0-9.-]", "", "all" ) )>
	</cfif>
	<cfset LOCAL.error = "{label} can not a valid action">
</cfif>

