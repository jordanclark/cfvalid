<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = reReplace( LOCAL.value, "[^[:digit:]]", "", "all" )>
</cfif>

<cfif NOT isNumeric( LOCAL.value ) OR reFindNoCase( "[^[:digit:]]", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = reReplace( LOCAL.value, "[^[:digit:]]", "", "all" )>
	</cfif>
	<cfset LOCAL.error = "{label} can only contain numbers (0-9).">
</cfif>
