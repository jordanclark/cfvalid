<cfif NOT isSimpleValue( LOCAL.value )>
	<cfif arguments.autoFix>
		<cfset LOCAL.value = "">
	</cfif>
	<cfset LOCAL.error = "{label} can only be a simple string value.">
</cfif>

