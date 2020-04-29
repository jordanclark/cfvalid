<cfif arguments.autoFix>
	<cfset LOCAL.value = reReplace( LOCAL.value, "[^0-9X]", "", "all" )>
</cfif>

<cfif NOT reFind( "^[0-9]{9,12}[0-9X]?$", LOCAL.value )>
	<cfset LOCAL.value = left( reReplace( LOCAL.value, "[^0-9X]", "", "all" ), 13 )>
	<cfset LOCAL.error = "{label} is not a valid ISBN code.">
</cfif>
