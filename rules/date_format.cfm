<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.mask" type="string" default="#LOCAL.ruleArg#">
<cfif NOT len( arguments.mask )>
	<cfset arguments.mask = "YYYY-MM-DD">
</cfif>

<cfif arguments.mutable>
	<cfset LOCAL.value = dateFormat( LOCAL.value, arguments.mask )>
</cfif>
