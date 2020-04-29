<cfif len( LOCAL.value ) AND arguments.autoFix>
	<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "<[/!]?(object|embed|script|applet|meta|link|frame|frameset|iframe)[^>]*>", "", "all" )>
</cfif>

<cfif len( LOCAL.value ) AND reFindNoCase( "<[/!]?(object|embed|script|applet|meta|link|frame|frameset|iframe).*>", LOCAL.value )>
	<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "<[/!]?(object|embed|script|applet|meta|link|frame|frameset|iframe)[^>]*>", "", "all" )>
	<cfset LOCAL.error = "{label} must not contain restricted HTML tags: object, embed, script, applet, meta, link, frameset, frame or iframe.">
</cfif>

