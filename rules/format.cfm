<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.lookup" type="boolean" default="false">

<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^[:alnum:]\-]", "", "all" )>
</cfif>

<cfif reFindNoCase( "[^[:alnum:]\-]", LOCAL.value )>
	<cfif arguments.mutable>
		<cfset LOCAL.value = "all">
	</cfif>
	<cfset LOCAL.error = "{label} is not valid.">

<cfelseif arguments.lookup>
	<cfif NOT cfc.format.exists( LOCAL.value )>
		<cfset LOCAL.value = "all">
		<cfset LOCAL.error = "{label} is not valid.">
	</cfif>
</cfif>


