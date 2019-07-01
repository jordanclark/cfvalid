<cfif arguments.mutable AND arguments.autoFix>
	<cfset LOCAL.value = reReplace( LOCAL.value, "[^[:print:]]", "", "all" )>
</cfif>

<cfif reFind( "[^[:print:]]", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = reReplace( LOCAL.value, "[^[:print:]]", "", "all" )>
	</cfif>
	<cfset LOCAL.error = "{label} can only contain normal printable characters.">
</cfif>

