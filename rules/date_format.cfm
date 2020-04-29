<cfparam name="arguments.mask" type="string" default="#LOCAL.ruleArg#">
<cfif NOT len( arguments.mask )>
	<cfset arguments.mask = "YYYY-MM-DD">
</cfif>

<cfset LOCAL.value = dateFormat( LOCAL.value, arguments.mask )>
