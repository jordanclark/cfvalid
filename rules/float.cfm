<cfif arguments.mutable AND arguments.autoFix>
	<cfset LOCAL.value = reReplace( LOCAL.value, "[^0-9.-]", "", "all" )>
</cfif>

<cfif NOT isNumeric( LOCAL.value ) OR NOT reFindNoCase( "^-?[0-9]+(\.[0-9]+)?$", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = reReplace( LOCAL.value, "[^0-9.-]", "", "all" )>
	</cfif>
	<cfset LOCAL.error = "{label} can only contain decimal numbers like 132.45">
</cfif>


