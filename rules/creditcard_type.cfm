<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.cardTypes" type="numeric" default="3">

<cfset LOCAL.cardType = [
	"m,a,v,d"
,	"mc,am,vi,ds"
,	"mc,amex,visa,disc"
,	"mastercard,amex,visa,discover"
]>

<cfif isNumeric( arguments.cardTypes )>
	<cfset LOCAL.searchList = LOCAL.cardType[ arguments.cardTypes ]>
<cfelse>
	<cfset LOCAL.searchList = lCase( arguments.cardTypes )>
</cfif>

<cfif NOT listFindNoCase( LOCAL.searchList, LOCAL.value )>
	<cfset LOCAL.error = "{label} is not a valid credit card type.">
</cfif>

