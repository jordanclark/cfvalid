<cfparam name="arguments.mask" type="string" default="#LOCAL.ruleArg#">
<cfif NOT len( arguments.mask )>
	<cfset arguments.mask = "YYYY-MM-DD HH:MM:SS">
</cfif>

<cfset LOCAL.value = dateTimeFormat( LOCAL.value, arguments.mask )>
