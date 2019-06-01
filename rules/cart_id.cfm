<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = replaceNoCase( reReplaceNoCase( LOCAL.value, "[^0-9A-]", "", "all" ), "A", "-" )>
</cfif>

<cfif NOT isNumeric( LOCAL.value ) OR LOCAL.value IS 0>
	<cfset LOCAL.error = "{label} is not a valid cart.">
</cfif>