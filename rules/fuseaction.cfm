<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfif arguments.mutable AND arguments.trim>
	<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^a-z0-9.-]", "", "all" ) )>
</cfif>

<cfif listLen( LOCAL.value, "." ) GT 2>
	<cfset LOCAL.error = "{label} can only contain letters (A-Z) and a period (.).">
<cfelseif NOT reFindNoCase( "^[a-z0-9.-]+$", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^a-z0-9.-]", "", "all" ) )>
	</cfif>
	<cfset LOCAL.error = "{label} can only contain letters (A-Z) and a period (.).">
</cfif>

