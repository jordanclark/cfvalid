<cfparam name="arguments.parseDate" type="boolean" default="false">

<cfif arguments.parseDate>
	<cfset LOCAL.value = parseDateTime( LOCAL.value )>
</cfif>

<cfif NOT isDate( LOCAL.value )>
	<cfset LOCAL.error = "{label} is not a valid date.">
</cfif>

