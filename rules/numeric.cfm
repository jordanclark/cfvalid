<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = reReplace( LOCAL.value, "[^[:digit:]]", "", "all" )>
</cfif>

<cfif NOT isNumeric( LOCAL.value ) OR reFindNoCase( "[^[:digit:]]", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = reReplace( LOCAL.value, "[^[:digit:]]", "", "all" )>
	</cfif>
	<cfset LOCAL.error = "{label} can only contain numbers (0-9).">
</cfif>
