<cfparam name="arguments.findList" type="string" default="">
<cfparam name="arguments.replaceList" type="string" default="">

<cfset LOCAL.value = replaceList( LOCAL.value, arguments.findList, arguments.replaceList )>
