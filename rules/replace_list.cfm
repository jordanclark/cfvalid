<cfparam name="arguments.findList" type="string" default="">
<cfparam name="arguments.replaceList" type="string" default="">

<cfif NOT arguments.mutable>
	<cfexit>
</cfif>

<cfset LOCAL.value = replaceList( LOCAL.value, arguments.findList, arguments.replaceList )>
