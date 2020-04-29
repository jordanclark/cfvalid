<cfparam name="arguments.verify" type="string" default="">
<cfparam name="arguments.passwordType" type="string" default="standard">
<cfparam name="arguments.caseSensitive" type="boolean" default="false">

<cfswitch expression="#arguments.passwordType#">

	<cfcase value="standard">
		<!--- values are the same --->
		<!--- only contain letters, numbers, underscore, hyphens --->
		<cfif reFindNoCase( "[^a-z0-9_-]", LOCAL.value )>
			<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^a-z0-9 _-]", "", "all" )>
			<cfset LOCAL.error = "{label} can only contain letters ""A-Z"", numbers ""0-9"" and the special characters hyphen ""-"" and underscores ""_"".">
		</cfif>
	</cfcase>
	
	<cfcase value="withSymbols">
		<cfif reFindNoCase( "[^a-z0-9~!@##$%^&*()_+=\[\]{}\\\|:;',./?-]", LOCAL.value )>
			<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^a-z0-9~!@##$%^&*()_+-=\[\]{}\\\|:;',./?-]", "", "all" )>
			<cfset LOCAL.error = "{label} can only contain letters ""A-Z"", numbers ""0-9"" and the special symbols: ~!@##$%^&*()_+=[]{}|:;',./?-">
		</cfif>
	</cfcase>
	
	<cfcase value="withNumbers">
		<cfif reFindNoCase( "[^a-z0-9]", LOCAL.value )>
			<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^a-z0-9]", "", "all" )>
			<cfset LOCAL.error = "{label} can only contain letters ""A-Z"", numbers ""0-9"".">
		</cfif>
	</cfcase>

</cfswitch>

<cfif NOT len( LOCAL.error ) AND len( arguments.verify )>
	<cfif NOT structKeyExists( LOCAL.scope, arguments.verify )>
		<cfset LOCAL.value = "">
		<cfset LOCAL.scope[ arguments.verify ] = "">
		<cfset LOCAL.error = "{label} fields must match.">
	<cfelseif arguments.caseSensitive>
		<cfif compare( LOCAL.value, LOCAL.scope[ arguments.verify ] ) IS NOT 0>
			<cfset LOCAL.value = "">
			<cfset LOCAL.scope[ arguments.verify ] = "">
			<cfset LOCAL.error = "{label} fields must be exactly the same, even the case.">
		</cfif>
	<cfelse>
		<cfif compareNoCase( LOCAL.value, LOCAL.scope[ arguments.verify ] ) IS NOT 0>
			<cfset LOCAL.value = "">
			<cfset LOCAL.scope[ arguments.verify ] = "">
			<cfset LOCAL.error = "{label} fields must be exactly the same.">
		</cfif>
	</cfif>
	
</cfif>
