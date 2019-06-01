<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.key" type="string" default="#app.urlKey#">

<cfif left( LOCAL.value, 1 ) IS "!">
	<cftry>
		<cfset LOCAL.value = listFirst( decrypt( replace( LOCAL.value, "!", "", "one" ), app.urlKey, "BLOWFISH", "HEX" ), "|" )>
		<cfcatch>
			<cfset LOCAL.value = "">
			<cfset LOCAL.error = "{label} couldn't be decrypted">
		</cfcatch>
	</cftry>
</cfif>
