<cfif arguments.autoFix>
	<cfset LOCAL.value = trim( reReplace( LOCAL.value, "[^[:digit:].-]", "", "all" ) )>
</cfif>

<cfif NOT isNumeric( LOCAL.value ) OR NOT reFindNoCase( "^-?[[:digit:]]+(\.[[:digit:]]+)?", LOCAL.value )>
	<cfset LOCAL.value = trim( reReplace( LOCAL.value, "[^[:digit:].-]", "", "all" ) )>
	<cfset LOCAL.error = "{label} can only contain numbers (0-9), and optionally a decimal and negative symbol.">
</cfif>
