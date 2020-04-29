<cfparam name="arguments.case" type="string" default="#LOCAL.ruleArg#">

<cfif arguments.case IS "upper">
	<cfset LOCAL.value = uCase( LOCAL.value )>
<cfelseif arguments.case IS "lower">
	<cfset LOCAL.value = lCase( LOCAL.value )>
</cfif>
