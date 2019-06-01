<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<!--- backup arguments --->
<cfset LOCAL.backupValue = LOCAL.value>
<cfset LOCAL.backupRules = LOCAL.rule>
<cfset LOCAL.otherRules = listRest( LOCAL.rule, ":," )>
<cfset LOCAL.allErrors = "">

<cfset this.debugLog( "!!Validating #LOCAL.otherRules#" )>

<cfloop index="LOCAL.rule" list="#LOCAL.otherRules#" delimiters=":,">
	<cfset LOCAL.error = "">
	<cfset LOCAL.value = LOCAL.backupValue>
	<cfinclude template="#this.rulePath( LOCAL.rule )#">
	<cfset this.debugLog( "!!Validating #arguments.var# OneOf: #LOCAL.rule# = [#LOCAL.error#]" )>
	<cfif NOT len( LOCAL.error )>
		<!--- no error, success! --->
		<cfbreak>
	</cfif>
</cfloop>
