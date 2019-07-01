<cfparam name="arguments.exclude" type="string" default="#LOCAL.ruleArg#">
<cfparam name="arguments.caseSensitive" type="boolean" default="true">

<cfif arguments.caseSensitive>
	<cfif compare( LOCAL.value, arguments.exclude ) IS 0>
		<cfset LOCAL.error = "{label} field must be exactly the same.">
	</cfif>

<!--- not case sensitive --->
<cfelse>
	<cfif compareNoCase( LOCAL.value, arguments.exclude ) IS 0>
		<cfset LOCAL.error = "{label} field must be exactly the same.">
	</cfif>
</cfif>

