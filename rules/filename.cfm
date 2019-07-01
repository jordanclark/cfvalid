<cfparam name="arguments.extension" type="string" default="">

<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = trim( LOCAL.value )>
</cfif>

<cfif reFindNoCase( "[\\/:\*\?""<>\|]", LOCAL.value )>
	<cfif arguments.mutable>
		<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[\\/:\*\?""'<>\|]", "", "all" )>
	</cfif>
	<cfset LOCAL.error = "{label} is invalid, a file name must not contain any of these characters: /<':*?""\|>">
	
<cfelseif len( arguments.extension ) AND NOT reFindNoCase( arguments.extension, listLast( LOCAL.value, "." ) )>
	<cfset LOCAL.error = "{label} is invalid, a file name must have the extension .#arguments.extension#">

</cfif>
