<cfif NOT isStruct( LOCAL.value )>
	<cfset LOCAL.error = "{label} is not a valid struct object.">
</cfif>

