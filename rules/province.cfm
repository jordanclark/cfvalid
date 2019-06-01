<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.provinceList" type="string" default="AB,BC,MB,NB,NF,NT,NS,NU,PE,QC,SK,YK,ON">

<cfif NOT listFindNoCase( arguments.provinceList, LOCAL.value )>
	<cfset LOCAL.value = "">
	<cfset LOCAL.error = "{label} is not a valid province.">
</cfif>
