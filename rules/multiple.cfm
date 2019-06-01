<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfif isSimpleValue( LOCAL.value )>
	<cfparam name="arguments.delimiters" type="string" default=",">
	<cfif len( LOCAL.value )>
		<!--- backup arguments --->
		<cfset LOCAL.multiOldValue = LOCAL.value>
		<cfset LOCAL.multiNewValue = []>
		<cfloop index="LOCAL.value" list="#LOCAL.multiOldValue#" delimiters="#arguments.delimiters#">
			<cfinclude template="#this.rulePath( LOCAL.ruleArg )#">
			<cfif arguments.mutable>
				<cfset arrayAppend( LOCAL.multiNewValue, LOCAL.value )>
			</cfif>
			<!--- <cfset this.debugLog( "!!Validating #arguments.var# Multiple: #listRest( LOCAL.rule, ':' )# '#LOCAL.value#' = [#LOCAL.error#]" )> --->
			<cfif len( LOCAL.error )>
				<cfbreak>
			</cfif>
		</cfloop>
		<!--- restore arguments --->
		<cfif arguments.mutable>
			<cfset LOCAL.value = arrayToList( LOCAL.multiNewValue, left( arguments.delimiters, 1 ) )>
		<cfelse>
			<cfset LOCAL.value = LOCAL.multiOldValue>
		</cfif>
	</cfif>
	
<cfelseif isArray( LOCAL.value )>
	<cfif arrayLen( LOCAL.value )>
		<!--- backup arguments --->
		<cfset LOCAL.multiOldValue = LOCAL.value>
		<cfset LOCAL.multiNewValue = []>
		<cfloop index="LOCAL.x" from="1" to="#arrayLen( LOCAL.multiOldValue )#">
			<cfset LOCAL.value = LOCAL.multiOldValue[ LOCAL.x ]>
			<cfinclude template="#this.rulePath#/#listRest( LOCAL.rule, ':' )#.cfm">
			<cfif arguments.mutable>
				<cfset arrayAppend( LOCAL.multiNewValue, LOCAL.value )>
			</cfif>
			<cfif len( LOCAL.error )>
				<cfbreak>
			</cfif>
		</cfloop>
		<!--- restore arguments --->
		<cfif arguments.mutable>
			<cfset LOCAL.value = LOCAL.multiNewValue>
		<cfelse>
			<cfset LOCAL.value = LOCAL.multiOldValue>
		</cfif>
	</cfif>
</cfif>

