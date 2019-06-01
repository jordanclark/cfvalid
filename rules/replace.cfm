<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.caseSensitive" type="boolean" default="false">
<!--- <cfparam name="arguments.find1" type="string"> --->
<!--- <cfparam name="arguments.find2" type="string"> --->
<!--- <cfparam name="arguments.find3" type="string"> --->

<cfif NOT arguments.mutable>
	<cfexit>
</cfif>

<cfloop index="LOCAL.x" from="1" to="10">
	<cfif structKeyExists( arguments, "find#LOCAL.x#" ) AND structKeyExists( arguments, "replace#LOCAL.x#" )>
		<cfset LOCAL.find = arguments[ "find#LOCAL.x#" ]>
		<cfset LOCAL.replace = arguments[ "replace#LOCAL.x#" ]>
		<cfif arguments.caseSensitive>
			<cfset LOCAL.value = replace( LOCAL.value, LOCAL.find, LOCAL.replace, "all" )>
		<cfelse>
			<cfset LOCAL.value = replaceNoCase( LOCAL.value, LOCAL.find, LOCAL.replace, "all" )>
		</cfif>
	<cfelseif structKeyExists( arguments, "refind#LOCAL.x#" ) AND structKeyExists( arguments, "replace#LOCAL.x#" )>
		<cfset LOCAL.find = arguments[ "refind#LOCAL.x#" ]>
		<cfset LOCAL.replace = arguments[ "replace#LOCAL.x#" ]>
		<cfif arguments.caseSensitive>
			<cfset LOCAL.value = reReplace( LOCAL.value, LOCAL.find, LOCAL.replace, "all" )>
		<cfelse>
			<cfset LOCAL.value = replaceNoCase( LOCAL.value, LOCAL.find, LOCAL.replace, "all" )>
		</cfif>
	<cfelse>
		<cfbreak>
	</cfif>
</cfloop>
