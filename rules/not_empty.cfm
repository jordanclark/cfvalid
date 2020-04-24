<cfif NOT len( LOCAL.value )>
	<cfif arguments.mutable AND arguments.autoFix>
		<cfset LOCAL.value = arguments.defaultValue>
	</cfif>
	<cfif arguments.required>
		<cfset LOCAL.error = "{label} is a required field that was skipped.">
	<cfelse>
		<cfset LOCAL.error = "stop">
	</cfif>
</cfif>
