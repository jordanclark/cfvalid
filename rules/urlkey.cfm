<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.noSpaces" type="boolean" default="false">

<cfif arguments.mutable AND arguments.autoFix>
	<cfset LOCAL.value = trim( LOCAL.value )>
</cfif>

<cfif arguments.mutable AND arguments.noSpaces>
	<cfset LOCAL.value = reReplace( LOCAL.value, "\s+", "-", "all" )>
</cfif>

<cfif NOT isSimpleValue( LOCAL.value ) OR reFindNoCase( "[^[:alnum:]\-]", LOCAL.value )>
	<cfif arguments.mutable>
		<cfset LOCAL.value = "">
	</cfif>
	<cfset LOCAL.error = "{label} is not a valid value.">
</cfif>

