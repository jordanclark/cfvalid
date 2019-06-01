<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.dollarSign" type="boolean" default="true">
<cfparam name="arguments.allowNegative" type="boolean" default="true">

<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = trim( reReplace( LOCAL.value, "[^0-9.\$-]", "", "all" ) )>
</cfif>

<cfset LOCAL.regex = "[0-9]+\.[0-9]{2,2}$">
<cfif arguments.dollarSign>
	<cfset LOCAL.regex = "\$" & LOCAL.regex>
</cfif>
<cfif arguments.allowNegative>
	<cfset LOCAL.regex = "-?" & LOCAL.regex>
</cfif>
<cfset LOCAL.regex = "^" & LOCAL.regex>

<cfif NOT reFindNoCase( LOCAL.regex, LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = reReplace( LOCAL.value, "[^0-9.\$-]", "", "all" )>
	</cfif>
	<cfif arguments.dollarSign>
		<cfset LOCAL.error = "{label} must be a valid dollar value, like $132.45">
	<cfelse>
		<cfset LOCAL.error = "{label} must be a valid dollar value, like 132.45">
	</cfif>
</cfif>


