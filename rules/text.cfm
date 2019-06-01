<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfif arguments.mutable AND arguments.autoFix>
	<cfset LOCAL.value = reReplace( LOCAL.value, "[^[:print:]]", "", "all" )>
</cfif>

<cfif reFind( "[^[:print:]]", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = reReplace( LOCAL.value, "[^[:print:]]", "", "all" )>
	</cfif>
	<cfset LOCAL.error = "{label} can only contain normal printable characters.">
</cfif>

