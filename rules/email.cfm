<cfif arguments.autoFix>
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
	<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^a-z0-9.!##$%&’'*+/=?^_`{|}~-]", "", "all" )>
	<cfset LOCAL.error = "{label} is invalid, an e-mail address must be like: fred@aol.com">
</cfif>
