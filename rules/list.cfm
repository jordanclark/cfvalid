<cfparam name="arguments.list" type="string" default="#LOCAL.ruleArg#">
<cfparam name="arguments.delimiters" type="string" default=",">
<cfparam name="arguments.caseSensitive" type="boolean" default="false">
<cfparam name="arguments.multiList" type="boolean" default="false">

<cfif arguments.caseSensitive>
	<cfif arguments.multiList>
		<cfloop index="LOCAL.singleValue" list="#LOCAL.value#" delimiters="#arguments.delimiters#">
			<cfif NOT listFind( arguments.list, LOCAL.singleValue, arguments.delimiters )>
				<cfset LOCAL.error = "{label} contains the value ""#xmlFormat( LOCAL.singleValue )#"" that was rejected, the only valid values are: ""#arguments.list#"" (case sensitive)"><cfexit>
			</cfif>
		</cfloop>
	<cfelseif NOT listFind( arguments.list, LOCAL.value, arguments.delimiters )>
		<cfset LOCAL.error = "{label} contains the value ""#xmlFormat( LOCAL.value )#"" that was rejected, the only valid values are: ""#arguments.list#"" (case sensitive)">
	</cfif>
	
<cfelse><!--- case-insensitive --->
	<cfif arguments.multiList>
		<cfloop index="LOCAL.singleValue" list="#LOCAL.value#" delimiters="#arguments.delimiters#">
			<cfif NOT listFindNoCase( arguments.list, LOCAL.singleValue, arguments.delimiters )>
				<cfset LOCAL.error = "{label} contains the value ""#xmlFormat( LOCAL.singleValue )#"" that was rejected, the only valid values are: ""#arguments.list#"""><cfexit>
			</cfif>
		</cfloop>
	<cfelseif NOT listFindNoCase( arguments.list, LOCAL.value, arguments.delimiters )>
		<cfset LOCAL.error = "{label} contains the value ""#xmlFormat( LOCAL.value )#"" that was rejected, the only valid values are: ""#arguments.list#""">
	</cfif>
</cfif>

