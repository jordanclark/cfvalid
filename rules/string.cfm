<cfparam name="arguments.noSpaces" type="boolean" default="false">

<cfif arguments.mutable AND arguments.autoFix AND isSimpleValue( LOCAL.value )>
	<cfset LOCAL.value = trim( LOCAL.value )>
</cfif>

<cfif arguments.mutable AND arguments.noSpaces AND isSimpleValue( LOCAL.value )>
	<cfset LOCAL.value = reReplace( LOCAL.value, "\s", "", "all" )>
</cfif>

<cfif NOT isSimpleValue( LOCAL.value )>
	<cfif arguments.mutable>
		<cfset LOCAL.value = "">
	</cfif>
	<cfset LOCAL.error = "{label} can only be a simple string value.">
</cfif>

