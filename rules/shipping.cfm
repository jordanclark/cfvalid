<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = left( reReplace( uCase( LOCAL.value ), "[^A-Z0-9,]", "", "all" ), 5 )>
</cfif>

<cfif NOT reFind( "^[A-Z]{2},[0-9]{1,2}$", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = left( reReplace( uCase( LOCAL.value ), "[^A-Z0-9,]", "", "all" ), 5 )>
	</cfif>
	<cfset LOCAL.error = "{label} is not valid.">
</cfif>

