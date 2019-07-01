<cfif NOT isQuery( LOCAL.value )>
	<cfset LOCAL.error = "{label} is not a valid query object.">
</cfif>

