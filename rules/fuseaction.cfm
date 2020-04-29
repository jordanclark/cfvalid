<cfif arguments.autoFix>
	<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^a-z0-9.-]", "", "all" ) )>
</cfif>

<cfif listLen( LOCAL.value, "." ) GT 2>
	<cfset LOCAL.error = "{label} can only contain letters (A-Z) and a period (.).">
<cfelseif NOT reFindNoCase( "^[a-z0-9.-]+$", LOCAL.value )>
	<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^a-z0-9.-]", "", "all" ) )>
	<cfset LOCAL.error = "{label} can only contain letters (A-Z) and a period (.).">
</cfif>

