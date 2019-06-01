<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = reReplace( LOCAL.value, "[^0-9X]", "", "all" )>
</cfif>

<cfif NOT reFind( "^[0-9]{9,12}[0-9X]?$", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = left( reReplace( LOCAL.value, "[^0-9X]", "", "all" ), 13 )>
	</cfif>
	<cfset LOCAL.error = "{label} is not a valid ISBN code.">
</cfif>
