<cfparam name="arguments.zipDivider" type="string" default="-">

<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^0-9]", "", "all" )>
	<cfif len( LOCAL.value ) GT 5>
		<cfset LOCAL.value = left( LOCAL.value, 9 )>
	<cfelse>
		<cfset LOCAL.value = left( LOCAL.value, 5 )>
	</cfif>
</cfif>


<cfif listFind( "12345,54321,11111,22222,33333,44444,55555,66666,77777,88888,99999,00000", LOCAL.value )>
	<cfif arguments.mutable>
		<cfset LOCAL.value = "">
	</cfif>
	<cfset LOCAL.error = "{label} is invalid, please enter a real zipcode.">
	

<cfelseif reFind( "^[0-9]{5}$", LOCAL.value )>
	<!--- golden --->

<cfelseif reFind( "^[0-9]{9}$", LOCAL.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = left( LOCAL.value, 5 ) & arguments.zipDivider & right( LOCAL.value, 4 )>
	</cfif>
	
<cfelse>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^0-9]", "", "all" )>
		<cfif len( LOCAL.value ) GT 5>
			<cfset LOCAL.value = left( LOCAL.value, 9 )>
		<cfelse>
			<cfset LOCAL.value = left( LOCAL.value, 5 )>
		</cfif>
	</cfif>
	<cfset LOCAL.error = "{label} is invalid, it must be in either ""12345"" or ""12345#arguments.zipDivider#6789"" format.">
</cfif>

