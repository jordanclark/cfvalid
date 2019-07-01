<cfif NOT isBinary( LOCAL.value )>
	<cfset LOCAL.error = "{label} is not a valid binary object.">
</cfif>

