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
