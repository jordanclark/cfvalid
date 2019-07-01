<cfparam name="arguments.condition" type="string">
<cfparam name="arguments.conditionError" type="string" default="failed validation">

<cfif evaluate( replace( arguments.condition, "{value}", LOCAL.value ), LOCAL.value ) IS false>
	<cfset LOCAL.error = "{label} #arguments.conditionError#">
</cfif>

