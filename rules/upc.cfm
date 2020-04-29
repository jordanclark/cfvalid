<cfif arguments.autoFix>
	<cfset LOCAL.value = reReplace( LOCAL.value, "[^0-9]", "", "all" )>
</cfif>

<cfif NOT reFind( "^[0-9]{12}$", LOCAL.value )>
	<cfset LOCAL.value = reReplace( LOCAL.value, "[^0-9]", "", "all" )>
	<cfset LOCAL.error = "{label} is not a valid UPC code.">
</cfif>
