<cfif arguments.autoFix>
	<cfset LOCAL.value = trim( LOCAL.value )>
</cfif>

<!--- only contain letters, numbers, underscore, hyphens, must start with a letter and end with a letter or number --->
<cfif reFindNoCase( "[^a-z0-9_\-]", LOCAL.value )>
	<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^a-z0-9_\-]", "", "all" ) )>
	<cfset LOCAL.error = "{label} must begin with a letter, and can only contain: letters and numbers plus underscores or hyphens.">
</cfif>

