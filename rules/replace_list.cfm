<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.findList" type="string" default="">
<cfparam name="arguments.replaceList" type="string" default="">

<cfif NOT arguments.mutable>
	<cfexit>
</cfif>

<cfset LOCAL.value = replaceList( LOCAL.value, arguments.findList, arguments.replaceList )>
