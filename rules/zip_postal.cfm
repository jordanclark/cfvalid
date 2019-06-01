<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.zipDivider" type="string" default=" ">
<cfparam name="arguments.postalDivider" type="string" default=" ">

<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^a-z0-9 -]", "", "all" ) )>
</cfif>

<!--- valid zipcode --->
<cfif reFindNoCase( "^[a-ceghj-npr-tvxy][0-9][a-z](-| )?[0-9][a-z][0-9]$", LOCAL.value )>
	<cfif arguments.autoFix AND arguments.mutable>
		<cfset LOCAL.value = left( LOCAL.value, 3 ) & arguments.postalDivider & right( LOCAL.value, 3 )>
	</cfif>

<!--- valid postalcode --->
<cfelseif reFindNoCase( "^[0-9]{5,5}((-| )?[0-9]{4,4})?$", LOCAL.value )>
	<cfif arguments.autoFix AND arguments.mutable AND len( LOCAL.value ) GTE 9>
		<cfset LOCAL.value = left( LOCAL.value, 5 ) & arguments.zipDivider & right( LOCAL.value, 4 )>
	</cfif>

<cfelse>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = trim( reReplaceNoCase( LOCAL.value, "[^a-z0-9 -]", "", "all" ) )>	
	</cfif>
	<cfset LOCAL.error = "{label} is not a valid Zip code or Postal code.<ul><li>Properly formated zip codes are ""12345"" or ""12345#arguments.zipDivider#6789""</li><li>Properly formatted postal codes are ""X0X#arguments.postalDivider#0X0""</li></ul>">
</cfif>
