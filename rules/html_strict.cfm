<cfif arguments.autoFix>
	<cfset LOCAL.value = reReplace( LOCAL.value, "<[/!]?[^>]*>", "", "all" )>
	<cfset LOCAL.value = htmlEditFormat( LOCAL.value )>
</cfif>

<cfif len( LOCAL.value ) AND reFindNoCase( "<[!/]?[a-z]*[0-9]?.*>", LOCAL.value )>
	<cfset LOCAL.value = reReplace( LOCAL.value, "<[/!]?[^>]*>", "", "all" )>
	<cfset LOCAL.value = htmlEditFormat( LOCAL.value )>
	<cfset LOCAL.error = "{label} must not contain any HTML tags.">
</cfif>