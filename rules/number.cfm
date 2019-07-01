<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = trim( reReplace( LOCAL.value, "[^[:digit:].-]", "", "all" ) )>
</cfif>

<cfif NOT isNumeric( LOCAL.value ) OR NOT reFindNoCase( "^-?[[:digit:]]+(\.[[:digit:]]+)?", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = trim( reReplace( LOCAL.value, "[^[:digit:].-]", "", "all" ) )>
	</cfif>
	<cfset LOCAL.error = "{label} can only contain numbers (0-9), and optionally a decimal and negative symbol.">
</cfif>
