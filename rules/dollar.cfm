<cfparam name="arguments.dollarSign" type="boolean" default="true">
<cfparam name="arguments.allowNegative" type="boolean" default="true">

<cfif arguments.autoFix>
	<cfset LOCAL.value = trim( reReplace( LOCAL.value, "[^0-9.\$-]", "", "all" ) )>
</cfif>

<cfset LOCAL.regex = "[0-9]+\.[0-9]{2,2}$">
<cfif arguments.dollarSign>
	<cfset LOCAL.regex = "\$" & LOCAL.regex>
</cfif>
<cfif arguments.allowNegative>
	<cfset LOCAL.regex = "-?" & LOCAL.regex>
</cfif>
<cfset LOCAL.regex = "^" & LOCAL.regex>

<cfif NOT reFindNoCase( LOCAL.regex, LOCAL.value )>
	<cfset LOCAL.value = reReplace( LOCAL.value, "[^0-9.\$-]", "", "all" )>
	<cfif arguments.dollarSign>
		<cfset LOCAL.error = "{label} must be a valid dollar value, like $132.45">
	<cfelse>
		<cfset LOCAL.error = "{label} must be a valid dollar value, like 132.45">
	</cfif>
</cfif>


