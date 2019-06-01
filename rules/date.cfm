<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.parseDate" type="boolean" default="false">

<cfif arguments.parseDate AND arguments.mutable>
	<cfset LOCAL.value = parseDateTime( LOCAL.value )>
</cfif>

<cfif NOT isDate( LOCAL.value )>
	<cfset LOCAL.error = "{label} is not a valid date.">
</cfif>

