<!--- Copyright 2005 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="htmlTags" type="string" default="B,STRONG,EM,I,FONT,UL,OL,LI,BR,P,DIV,SPAN,ADDRESS">

<cfset arguments.htmlTagsRegex = replace( arguments.htmlTags, ",", "|", "all" )>

<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "<[/!]?(#arguments.htmlTagsRegex#)[^>]*>", "", "all" )>
</cfif>

<cfif len( LOCAL.value ) AND ( find( "<", LOCAL.value ) OR find( ">", LOCAL.value ) )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset LOCAL.value = htmlEditFormat( LOCAL.value )>
		<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "&lt;(/?)(#arguments.htmlTagsRegex#)([^(&gt;)]*)&gt;", "<\1\2\3>", "all" )>
	</cfif>
	<cfset LOCAL.error = "{label} can only contain these HTML tags: #replace( arguments.htmlTags, ',', ', ', 'all' )#.">
</cfif>
