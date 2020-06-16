<cfparam name="arguments.noSpaces" type="boolean" default="false">

<cfif arguments.autoFix>
	<cfset LOCAL.value = trim( LOCAL.value )>
	<cfif arguments.noSpaces>
		<cfset LOCAL.value = reReplace( LOCAL.value, "\s", "", "all" )>
	</cfif>
</cfif>

<cfif NOT isSimpleValue( LOCAL.value )>
	<cfset LOCAL.value = "">
	<cfset LOCAL.error = "{label} can only be a simple string value.">
</cfif>
