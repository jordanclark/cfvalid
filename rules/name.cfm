<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = trim( reReplace( LOCAL.value, "[^[:alpha:].', -]", "", "all" ) )>
</cfif>

<cfif NOT reFind( "^[[:alpha:]]+[[:alpha:]\.', -]*([[:alpha:]]|\.)$", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = trim( reReplace( LOCAL.value, "[^[:alpha:].', -]", "", "all" ) )>
	</cfif>
	<cfset LOCAL.error = "{label} should only contain valid letters, spaces and punctuations.">
</cfif>

