<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = reReplace( LOCAL.value, "[^0-9]", "", "all" )>
</cfif>

<cfif NOT reFind( "^[0-9]{12}$", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = reReplace( LOCAL.value, "[^0-9]", "", "all" )>
	</cfif>
	<cfset LOCAL.error = "{label} is not a valid UPC code.">
</cfif>
