<cfparam name="arguments.lookup" type="boolean" default="false">

<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^[:alnum:]\-]", "", "all" )>
</cfif>

<cfif reFindNoCase( "[^[:alnum:]\-]", LOCAL.value )>
	<cfif arguments.mutable>
		<cfset LOCAL.value = "all">
	</cfif>
	<cfset LOCAL.error = "{label} is not valid.">

<cfelseif arguments.lookup>
	<cfif NOT cfc.format.exists( LOCAL.value )>
		<cfset LOCAL.value = "all">
		<cfset LOCAL.error = "{label} is not valid.">
	</cfif>
</cfif>


