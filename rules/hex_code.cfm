<cfif arguments.mutable AND arguments.autoFix>
	<cfset LOCAL.value = reReplace( uCase( LOCAL.value ), "[^A-F0-9]+", "", "all" )>
</cfif>

<cfif reFindNoCase( "[^[A-F0-9]]", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = reReplace( uCase( LOCAL.value ), "[^A-F0-9]+", "", "all" )>
	</cfif>
	<cfset LOCAL.error = "{label} can only contain numbers (0-9) and letters (A-F).">
</cfif>

