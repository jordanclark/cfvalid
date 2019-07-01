<cfparam name="arguments.noSpaces" type="boolean" default="false">

<cfif arguments.mutable AND arguments.autoFix>
	<cfset LOCAL.value = trim( LOCAL.value )>
</cfif>

<cfif arguments.mutable AND arguments.noSpaces>
	<cfset LOCAL.value = reReplace( LOCAL.value, "\s+", "-", "all" )>
</cfif>

<cfif NOT isSimpleValue( LOCAL.value ) OR reFindNoCase( "[^[:alnum:]\-]", LOCAL.value )>
	<cfif arguments.mutable>
		<cfset LOCAL.value = "">
	</cfif>
	<cfset LOCAL.error = "{label} is not a valid value.">
</cfif>

