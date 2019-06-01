<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.condition" type="string">
<cfparam name="arguments.conditionError" type="string" default="failed validation">

<cfif evaluate( replace( arguments.condition, "{value}", LOCAL.value ), LOCAL.value ) IS false>
	<cfset LOCAL.error = "{label} #arguments.conditionError#">
</cfif>

