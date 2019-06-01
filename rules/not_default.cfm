<!--- Copyright 2005 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.notDefault" type="string" default="#LOCAL.ruleArg#">

<cfif LOCAL.value IS arguments.notDefault AND arguments.mutable AND arguments.autoFix>
	<cfset LOCAL.value = "">
</cfif>

<cfif NOT len( LOCAL.value )>
	<cfif arguments.required>
		<cfset LOCAL.error = "{label} is a required field that was skipped.">
	<cfelse>
		<cfset LOCAL.error = "stop">
	</cfif>
</cfif>
