<cfif isSimpleValue( LOCAL.value )>
	<cfparam name="arguments.delimiters" type="string" default=",">
	<cfif len( LOCAL.value )>
		<!--- backup arguments --->
		<cfset LOCAL.multiOldValue = LOCAL.value>
		<cfset LOCAL.multiNewValue = []>
		<cfloop index="LOCAL.value" list="#LOCAL.multiOldValue#" delimiters="#arguments.delimiters#">
			<cfinclude template="#this.rulePath( LOCAL.ruleArg )#">
			<cfset arrayAppend( LOCAL.multiNewValue, LOCAL.value )>
			<!--- <cfset this.debugLog( "!!Validating #arguments.var# Multiple: #listRest( LOCAL.rule, ':' )# '#LOCAL.value#' = [#LOCAL.error#]" )> --->
			<cfif len( LOCAL.error )>
				<cfbreak>
			</cfif>
		</cfloop>
		<!--- restore arguments --->
		<cfset LOCAL.value = arrayToList( LOCAL.multiNewValue, left( arguments.delimiters, 1 ) )>
	</cfif>
	
<cfelseif isArray( LOCAL.value )>
	<cfif arrayLen( LOCAL.value )>
		<!--- backup arguments --->
		<cfset LOCAL.multiOldValue = LOCAL.value>
		<cfset LOCAL.multiNewValue = []>
		<cfloop index="LOCAL.x" from="1" to="#arrayLen( LOCAL.multiOldValue )#">
			<cfset LOCAL.value = LOCAL.multiOldValue[ LOCAL.x ]>
			<cfinclude template="#this.rulePath#/#listRest( LOCAL.rule, ':' )#.cfm">
			<cfset arrayAppend( LOCAL.multiNewValue, LOCAL.value )>
			<cfif len( LOCAL.error )>
				<cfbreak>
			</cfif>
		</cfloop>
		<!--- restore arguments --->
		<cfset LOCAL.value = LOCAL.multiNewValue>
	</cfif>
</cfif>

