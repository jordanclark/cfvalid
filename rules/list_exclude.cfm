<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.exclude" type="string" default="#LOCAL.ruleArg#">
<cfparam name="arguments.delimiters" type="string" default=",">
<cfparam name="arguments.caseSensitive" type="boolean" default="false">
<cfparam name="arguments.multiList" type="boolean" default="false">
<cfparam name="arguments.showExcluded" type="boolean" default="false">

<cfif arguments.caseSensitive>
	<cfif arguments.multiList>
		<cfloop index="LOCAL.singleValue" list="#LOCAL.value#" delimiters="#arguments.delimiters#">
			<cfif listFind( arguments.exclude, LOCAL.singleValue, arguments.delimiters )>
				<cfset LOCAL.error = "{label} contains the value ""#xmlFormat( LOCAL.singleValue )#"" that is not acceptable">
				<cfif arguments.showExcluded>
					<cfset LOCAL.error &= ", these values are restricted: #arguments.exclude# (case sensitive)">
				</cfif>
				<cfbreak>
			</cfif>
		</cfloop>
	<cfelse>
		<cfif listFind( arguments.exclude, LOCAL.value, arguments.delimiters )>
			<cfif arguments.showExcluded>
				<cfset LOCAL.error = "{label} can not be ""#xmlFormat( LOCAL.value )#"", these values are restricted: #arguments.exclude# (case sensitive)">
			<cfelse>
				<cfset LOCAL.error = "{label} can not be ""#xmlFormat( LOCAL.value )#"" (case sensitive)">
			</cfif>
		</cfif>
	</cfif>
	
<cfelseif NOT arguments.caseSensitive>
	<cfif arguments.multiList>
		<cfloop index="LOCAL.singleValue" list="#LOCAL.value#" delimiters="#arguments.delimiters#">
			<cfif listFindNoCase( arguments.exclude, LOCAL.singleValue, arguments.delimiters )>
				<cfset LOCAL.error = "{label} contains the value ""#xmlFormat( LOCAL.singleValue )#"" that is not acceptable">
				<cfif arguments.showExcluded>
					<cfset LOCAL.error &= ", these values are restricted: #arguments.exclude#">
				</cfif>
				<cfbreak>
			</cfif>
		</cfloop>
	<cfelse>
		<cfif listFindNoCase( arguments.exclude, LOCAL.value, arguments.delimiters )>
			<cfif arguments.showExcluded>
				<cfset LOCAL.error = "{label} can not be ""#xmlFormat( LOCAL.value )#"", these values are restricted: #arguments.exclude#">
			<cfelse>
				<cfset LOCAL.error = "{label} can not be ""#xmlFormat( LOCAL.value )#""">
			</cfif>
		</cfif>
	</cfif>
</cfif>

