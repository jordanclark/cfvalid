<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^[:alnum:]\-]", "", "all" )>
</cfif>

<cfif reFindNoCase( "[^[:alnum:]\-]", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^[:alnum:]\-]", "", "all" )>
	</cfif>
	<cfset LOCAL.error = "{label} can only be valid keywords.">
</cfif>

