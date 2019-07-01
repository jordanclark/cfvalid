<!--- 20181029 --->

<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = reReplace( LOCAL.value, "[^[:digit:]]", "", "all" )>
</cfif>

<cfif NOT isNumeric( LOCAL.value )>
	<cfset LOCAL.error = "{label} is not a valid number.">
<cfelseif len( LOCAL.value ) IS NOT 8>
	<cfset LOCAL.error = "{label} is not a valid number with 8 digits.">
<cfelseif NOT reFind( "[12][0-9][0-9][0-9][01][0-9][0-3][0-9]", LOCAL.value )>
	<cfset LOCAL.error = "{label} is not a valid date number.">
<cfelse>
	<cftry>
		<cfset LOCAL.value = createDate( mid( LOCAL.value, 1, 4 ), mid( LOCAL.value, 5, 2 ), mid( LOCAL.value, 7, 2 ) )>
		<!--- <cfset LOCAL.value = dateFormat( LOCAL.value, "YYYYMMDD" )> --->
		<cfcatch>
			<cfset LOCAL.value = "">
			<cfset LOCAL.error = "{label} " & (cfcatch.message?:"No catch message")>
		</cfcatch>
	</cftry>
</cfif>
