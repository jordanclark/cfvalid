<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.date" type="date" default="#now()#">

<cfif dateCompare( arguments.date, dateAdd( "m", 1, dateAdd( "d", -1, LOCAL.value ) ) ) IS 1>
	<cfset LOCAL.error = "{label} has already expired, please verify or select a newer card.">
</cfif>
