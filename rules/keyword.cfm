<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^[:alnum:]\-]", "", "all" )>
</cfif>

<cfif reFindNoCase( "[^[:alnum:]\-]", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^[:alnum:]\-]", "", "all" )>
	</cfif>
	<cfset LOCAL.error = "{label} can only be valid keywords.">
</cfif>

