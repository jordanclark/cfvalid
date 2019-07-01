<cfparam name="arguments.mask" type="string" default="#LOCAL.ruleArg#">
<cfif NOT len( arguments.mask )>
	<cfset arguments.mask = "HH:MM:SS">
</cfif>

<cfif arguments.mutable>
	<cfset LOCAL.value = timeFormat( LOCAL.value, arguments.mask )>
</cfif>
