<cfparam name="htmlTags" type="string" default="B,STRONG,EM,I,FONT,UL,OL,LI,BR,P,DIV,SPAN,ADDRESS">

<cfset arguments.htmlTagsRegex = replace( arguments.htmlTags, ",", "|", "all" )>

<cfif arguments.autoFix>
	<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "<[/!]?(#arguments.htmlTagsRegex#)[^>]*>", "", "all" )>
</cfif>

<cfif len( LOCAL.value ) AND ( find( "<", LOCAL.value ) OR find( ">", LOCAL.value ) )>
	<cfset LOCAL.value = htmlEditFormat( LOCAL.value )>
	<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "&lt;(/?)(#arguments.htmlTagsRegex#)([^(&gt;)]*)&gt;", "<\1\2\3>", "all" )>
	<cfset LOCAL.error = "{label} can only contain these HTML tags: #replace( arguments.htmlTags, ',', ', ', 'all' )#.">
</cfif>
