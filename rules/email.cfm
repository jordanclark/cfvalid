<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = reReplace( LOCAL.value, "\s", "", "all" )>
</cfif>

<cfif NOT find( "@", LOCAL.value )>
	<cfset LOCAL.error = "{label} is invalid without an ""@"" symbol, an e-mail address must be like: fred@aol.com">
<cfelseif listLen( LOCAL.value, "@" ) GT 2>
	<cfset LOCAL.error = "{label} is invalid with multiple ""@"" symbols, an e-mail address must be like: fred@aol.com">
<cfelseif NOT find( ".", LOCAL.value )>
	<cfset LOCAL.error = "{label} is invalid without a period ""."", an e-mail address must be like: fred@aol.com">
<!--- must contain "@" AND "." --->
<!--- only contain letters, numbers, underscores, hyphens, periods, "@" symbol --->
<cfelseif NOT reFindNoCase( "^[a-z0-9.!##$%&’'*+/=?^_`{|}~-]+@[a-z0-9-]+(\.[a-z0-9-]+)*$", LOCAL.value )>
	<cfif arguments.mutable>
		<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^a-z0-9.!##$%&’'*+/=?^_`{|}~-]", "", "all" )>
	</cfif>
	<cfset LOCAL.error = "{label} is invalid, an e-mail address must be like: fred@aol.com">
</cfif>
