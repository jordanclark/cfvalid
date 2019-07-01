<cfparam name="arguments.provinceList" type="string" default="AB,BC,MB,NB,NF,NT,NS,NU,PE,QC,SK,YK,ON">

<cfif NOT listFindNoCase( arguments.provinceList, LOCAL.value )>
	<cfset LOCAL.value = "">
	<cfset LOCAL.error = "{label} is not a valid province.">
</cfif>
