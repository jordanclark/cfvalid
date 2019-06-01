<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^a-z0-9-]", "", "all" )>
</cfif>

<cfif NOT reFindNoCase( "^[a-z0-9-]+$", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^a-z0-9-]", "", "all" )>
	</cfif>
	<cfset LOCAL.error = "{label} is not a valid gift code.">

<!--- <cfelseif len( LOCAL.value ) GT 15 OR len( LOCAL.value ) LT 3>
	<cfif arguments.mutable>
		<cfset LOCAL.value = left( LOCAL.value, 15 )>
	</cfif>
	<cfset LOCAL.error = "{label} must be between 3-15 characters long."> --->
	
</cfif>

