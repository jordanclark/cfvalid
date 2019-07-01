<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = left( reReplace( uCase( LOCAL.value ), "[^A-Z0-9,]", "", "all" ), 5 )>
</cfif>

<cfif NOT reFind( "^[A-Z]{2},[0-9]{1,2}$", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = left( reReplace( uCase( LOCAL.value ), "[^A-Z0-9,]", "", "all" ), 5 )>
	</cfif>
	<cfset LOCAL.error = "{label} is not valid.">
</cfif>

