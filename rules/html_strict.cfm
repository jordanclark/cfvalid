<!--- Copyright 2005 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfif len( LOCAL.value ) AND reFindNoCase( "<[!/]?[a-z]*[0-9]?.*>", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = reReplace( LOCAL.value, "<[/!]?[^>]*>", "", "all" )>
		<cfset LOCAL.value = htmlEditFormat( LOCAL.value )>
	</cfif>
	<cfset LOCAL.error = "{label} must not contain any HTML tags.">
</cfif>