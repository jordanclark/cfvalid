<cfparam name="arguments.date" type="date" default="#now()#">

<cfif dateCompare( arguments.date, dateAdd( "m", 1, dateAdd( "d", -1, LOCAL.value ) ) ) IS 1>
	<cfset LOCAL.error = "{label} has already expired, please verify or select a newer card.">
</cfif>
