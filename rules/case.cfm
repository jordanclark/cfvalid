<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.case" type="string" default="#LOCAL.ruleArg#">

<cfif arguments.mutable>
	<cfif arguments.case IS "upper">
		<cfset LOCAL.value = uCase( LOCAL.value )>
	<cfelseif arguments.case IS "lower">
		<cfset LOCAL.value = lCase( LOCAL.value )>
	</cfif>
</cfif>
