<cfparam name="arguments.contains" type="string" default="#LOCAL.ruleArg#">
<cfparam name="arguments.caseSensitive" type="boolean" default="false">
<!--- <cfparam name="arguments.containsReplace" type="string"> --->
<cfparam name="arguments.containsError" type="string">

<cfif arguments.caseSensitive>
	<cfif reFind( arguments.contains, LOCAL.value )>
		<cfset LOCAL.error = "{label} #arguments.containsError#.">
		<cfif arguments.mutable AND structKeyExists( arguments, "containsReplace" )>
			<cfset LOCAL.value = reReplace( LOCAL.value, arguments.contains, arguments.containsReplace, "all" )>
		</cfif>
	</cfif>
<cfelse>
	<cfif reFindNoCase( arguments.contains, LOCAL.value )>
		<cfset LOCAL.error = "{label} #arguments.containsError#.">
		<cfif arguments.mutable AND structKeyExists( arguments, "containsReplace" )>
			<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, arguments.contains, arguments.containsReplace, "all" )>
		</cfif>
	</cfif>
</cfif>
