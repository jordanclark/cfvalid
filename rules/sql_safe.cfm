<cfparam name="arguments.sqlSafe" type="string" default="keywords,functions,escape">
<cfparam name="arguments.sqlKeywords" type="string" default="delete,insert,select,update,drop,alter,create">

<cfif listFindNoCase( arguments.sqlSafe, "keywords" )>
	<cfloop index="LOCAL.word" list="#arguments.sqlKeywords#" delimiters=",">
		<cfif reFindNoCase( "\b#LOCAL.word#\b", LOCAL.value )>
			<cfset LOCAL.value = "">
			<cfset LOCAL.error = "{label} contained the restricted word ""#LOCAL.word#"", please retry.">
			<cfbreak>
		</cfif>
	</cfloop>
</cfif>

<cfif listFindNoCase( arguments.sqlSafe, "functions" )>
	<cfif find( "(", LOCAL.value ) OR find( ")", LOCAL.value )>
		<cfset LOCAL.value = "">
		<cfset LOCAL.error = "{label} contained the restricted characters, please retry.">
	</cfif>
</cfif>

<cfif ( listFindNoCase( arguments.sqlSafe, "escape" ) OR arguments.autoFix )>
	<cfset LOCAL.value = replace( LOCAL.value, "'", "&##39", "all" )>
	<!---<cfset LOCAL.value = replace( LOCAL.value, "'", "''", "all" )>--->
	<cfset LOCAL.value = replaceList( LOCAL.value, "--,/*,*/", "" )>
</cfif>	