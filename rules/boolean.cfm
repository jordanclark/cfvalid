<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.booleanType" type="string" default="true_false">

<cfif isBoolean( LOCAL.value )>
	<cfif arguments.mutable AND arguments.autoFix>
		<cfswitch expression="#arguments.booleanType#">
			<cfcase value="truefalse,true_false">
				<cfif LOCAL.value IS true>
					<cfset LOCAL.value = "true">
				<cfelse>
					<cfset LOCAL.value = "false">
				</cfif>
			</cfcase>
			<cfcase value="yesno,yes_no">
				<cfif LOCAL.value IS true>
					<cfset LOCAL.value = "yes">
				<cfelse>
					<cfset LOCAL.value = "no">
				</cfif>
			</cfcase>
			<cfcase value="onoff,on_off">
				<cfif LOCAL.value IS true>
					<cfset LOCAL.value = "on">
				<cfelse>
					<cfset LOCAL.value = "off">
				</cfif>
			</cfcase>
			<cfcase value="bit">
				<cfif LOCAL.value IS true>
					<cfset LOCAL.value = "1">
				<cfelse>
					<cfset LOCAL.value = "0">
				</cfif>
			</cfcase>
		</cfswitch>
	</cfif>
<cfelse>
	<cfif arguments.mutable>
		<cfset LOCAL.value = "">
	</cfif>
	<cfset LOCAL.error = "{label} can only be a ""true"" or ""false"" value.">
</cfif>

