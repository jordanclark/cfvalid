<cfparam name="arguments.notDefault" type="string" default="#arguments.defaultValue#">

<cfif LOCAL.value IS arguments.notDefault AND arguments.autoFix>
	<cfset LOCAL.value = "">
</cfif>

<cfif NOT len( LOCAL.value )>
	<cfif arguments.required>
		<cfset LOCAL.error = "{label} is a required field that was skipped.">
	<cfelse>
		<cfset LOCAL.error = "stop">
	</cfif>
</cfif>
