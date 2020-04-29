<cfif arguments.autoFix>
	<cfset LOCAL.value = reReplace( LOCAL.value, "[^0-9.-]", "", "all" )>
</cfif>

<cfif NOT isNumeric( LOCAL.value ) OR NOT reFindNoCase( "^-?[0-9]+(\.[0-9]+)?$", LOCAL.value )>
	<cfset LOCAL.value = reReplace( LOCAL.value, "[^0-9.-]", "", "all" )>
	<cfset LOCAL.error = "{label} can only contain decimal numbers like 132.45">
</cfif>


