<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.verify" type="string" default="">
<cfparam name="arguments.passwordType" type="string" default="standard">
<cfparam name="arguments.caseSensitive" type="boolean" default="false">

<cfswitch expression="#arguments.passwordType#">

	<cfcase value="standard">
		<!--- values are the same --->
		<!--- only contain letters, numbers, underscore, hyphens --->
		<cfif reFindNoCase( "[^a-z0-9_-]", LOCAL.value )>
			<cfif arguments.mutable>
				<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^a-z0-9 _-]", "", "all" )>
			</cfif>
			<cfset LOCAL.error = "{label} can only contain letters ""A-Z"", numbers ""0-9"" and the special characters hyphen ""-"" and underscores ""_"".">
		</cfif>
	</cfcase>
	
	<cfcase value="withSymbols">
		<cfif reFindNoCase( "[^a-z0-9~!@##$%^&*()_+=\[\]{}\\\|:;',./?-]", LOCAL.value )>
			<cfif arguments.mutable>
				<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^a-z0-9~!@##$%^&*()_+-=\[\]{}\\\|:;',./?-]", "", "all" )>
			</cfif>
			<cfset LOCAL.error = "{label} can only contain letters ""A-Z"", numbers ""0-9"" and the special symbols: ~!@##$%^&*()_+=[]{}|:;',./?-">
		</cfif>
	</cfcase>
	
	<cfcase value="withNumbers">
		<cfif reFindNoCase( "[^a-z0-9]", LOCAL.value )>
			<cfif arguments.mutable>
				<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^a-z0-9]", "", "all" )>
			</cfif>
			<cfset LOCAL.error = "{label} can only contain letters ""A-Z"", numbers ""0-9"".">
		</cfif>
	</cfcase>

</cfswitch>

<cfif NOT len( LOCAL.error ) AND len( arguments.verify )>
	<cfif NOT structKeyExists( LOCAL.scope, arguments.verify )>
		<cfif arguments.mutable>
			<cfset LOCAL.value = "">
			<cfset LOCAL.scope[ arguments.verify ] = "">
		</cfif>
		<cfset LOCAL.error = "{label} fields must match.">
	<cfelseif arguments.caseSensitive>
		<cfif compare( LOCAL.value, LOCAL.scope[ arguments.verify ] ) IS NOT 0>
			<cfif arguments.mutable>
				<cfset LOCAL.value = "">
				<cfset LOCAL.scope[ arguments.verify ] = "">
			</cfif>
			<cfset LOCAL.error = "{label} fields must be exactly the same, even the case.">
		</cfif>
	<cfelse>
		<cfif compareNoCase( LOCAL.value, LOCAL.scope[ arguments.verify ] ) IS NOT 0>
			<cfif arguments.mutable>
				<cfset LOCAL.value = "">
				<cfset LOCAL.scope[ arguments.verify ] = "">
			</cfif>
			<cfset LOCAL.error = "{label} fields must be exactly the same.">
		</cfif>
	</cfif>
	
</cfif>
