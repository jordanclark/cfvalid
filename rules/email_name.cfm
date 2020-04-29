<cfif arguments.autoFix>
	<cfset LOCAL.value = trim( LOCAL.value )>
</cfif>

<!--- must contain "@" AND "." --->
<cfif NOT find( "@", LOCAL.value )>
	<cfset LOCAL.error = "{label} is invalid without a ""@"" symbol, an e-mail address must be like: ""Fed Flintston"" <fred@domain.com>">
<cfelseif listLen( LOCAL.value, "@" ) GT 2>
	<cfset LOCAL.error = "{label} is invalid with multiple ""@"" symbols, an e-mail address must be like: ""Fed Flintston"" <fred@aol.com>">
<cfelseif NOT find( ".", LOCAL.value )>
	<cfset LOCAL.error = "{label} is invalid without a period ""."", an e-mail address must be like: ""Fed Flintston"" <fred@domain.com>">

<!--- only contain letters, numbers, underscores, hyphens, periods, "@" symbol --->
<cfelseif NOT reFindNoCase( "^[""'](?:[A-Z0-9-]+ ){1,4}[""'] <[a-z0-9.!##$%&’'*+/=?^_`{|}~-]+@[a-z0-9-]+(\.[a-z0-9-]+)*>$", LOCAL.value )>
	<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^a-z0-9.!##$%&’'*+/=?^_`{|}~- ]", "", "all" )>
	<cfset LOCAL.error = "{label} is invalid, an email address must be formatted like: ""Fed Flintston"" <fred@domain.com>">
</cfif>
