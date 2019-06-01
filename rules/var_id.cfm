<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^a-z0-9$ _-]", "", "all" )>
</cfif>

<cfif NOT reFindNoCase( "^[a-z0-9$ _-]+$", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^a-z0-9$  _-]", "", "all" )>
	</cfif>
	<cfset LOCAL.error = "{label} is not a valid product number.">

<cfelseif len( LOCAL.value ) GT 8 OR len( LOCAL.value ) LT 1>
	<cfif arguments.mutable>
		<cfset LOCAL.value = left( LOCAL.value, 15 )>
	</cfif>
	<cfset LOCAL.error = "{label} must be between 1-8 characters long.">
	
</cfif>

