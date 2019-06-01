<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.postalDivider" type="string" default=" ">

<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^a-z0-9 -]", "", "all" ) )>
</cfif>

<cfif NOT reFindNoCase( "^[a-ceghj-npr-tvxy][0-9][a-z](-| )?[0-9][a-z][0-9]$", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^a-z0-9 -]", "", "all" ) )>
	</cfif>
	<cfset LOCAL.error = "{label} is an invalid Postal code. Postal codes must be in the ""X0X#arguments.postalDivider#0X0"" format.">

<cfelseif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = left( LOCAL.value, 3 ) & arguments.postalDivider & right( LOCAL.value, 3 )>
</cfif>
