<cfparam name="arguments.noSpaces" type="boolean" default="false">

<cfif NOT isSimpleValue( LOCAL.value )>
	<cfset LOCAL.value = "">
	<cfset LOCAL.error = "{label} can only be a simple string value.">
<cfelse>
	<cfif arguments.autoFix AND arguments.noSpaces>
		<cfset LOCAL.value = reReplace( LOCAL.value, "\s", "", "all" )>
	<cfelseif arguments.autoFix>
		<cfset LOCAL.value = trim( LOCAL.value )>
	</cfif>
</cfif>	

