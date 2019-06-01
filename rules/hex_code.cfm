<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfif arguments.mutable AND arguments.autoFix>
	<cfset LOCAL.value = reReplace( uCase( LOCAL.value ), "[^A-F0-9]+", "", "all" )>
</cfif>

<cfif reFindNoCase( "[^[A-F0-9]]", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = reReplace( uCase( LOCAL.value ), "[^A-F0-9]+", "", "all" )>
	</cfif>
	<cfset LOCAL.error = "{label} can only contain numbers (0-9) and letters (A-F).">
</cfif>

