<cfparam name="arguments.mask" type="string" default="#LOCAL.ruleArg#">
<cfif NOT len( arguments.mask )>
	<cfset arguments.mask = "HH:MM:SS">
</cfif>

<cfset LOCAL.value = timeFormat( LOCAL.value, arguments.mask )>
