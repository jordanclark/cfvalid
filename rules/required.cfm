<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<!--- give the variable a default if it doesn't exist or if its null --->
<cfif NOT structKeyExists( LOCAL.scope, arguments.var )>
	<cfif arguments.required>
		<!--- throw an error and stop processing of further rules --->
		<cfset LOCAL.error = "{label} is a required field that was skipped.">
	<cfelse>
		<cfset LOCAL.error = "stop">
		<cfif arguments.mutable>
			<!--- stop prevents further rules from processing but doesn't generate an error --->
			<cfset LOCAL.value = arguments.default>
		</cfif>
	</cfif>
	<!--- give the variable a default if it doesn't exist or if its null --->
<cfelseif isNull( LOCAL.scope[ arguments.var ] )>
	<cfif arguments.required>
		<!--- throw an error and stop processing of further rules --->
		<cfset LOCAL.error = "{label} is a required field that was skipped.">
	<cfelse>
		<cfset LOCAL.error = "stop">
		<!--- set the value to the default if its not required --->
		<cfif arguments.mutable>
			<!--- stop prevents further rules from processing but doesn't generate an error --->
			<cfset LOCAL.value = arguments.default>
		</cfif>
	</cfif>
<cfelse><!--- defined --->
	<cfset LOCAL.value = LOCAL.scope[ arguments.var ]>
	<cfif isSimpleValue( LOCAL.value )>
		<!--- trim space --->
		<cfif arguments.trim AND arguments.mutable>
			<cfset LOCAL.value = trim( LOCAL.value )>
		</cfif>
		<!--- ensure required field has value --->
		<cfif NOT len( LOCAL.value )>
			<cfif arguments.required>
				<cfset LOCAL.error = "{label} is a required field that was skipped.">
			<cfelse>
				<cfset LOCAL.error = "stop">
				<cfif arguments.mutable>
					<!--- stop prevents further rules from processing but doesn't generate an error --->
					<cfset LOCAL.value = arguments.default>
				</cfif>
			</cfif>
		</cfif>
	<cfelseif isArray( LOCAL.value )>
		<!--- ensure required field has value --->
		<cfif NOT arrayLen( LOCAL.value )>
			<cfif arguments.required>
				<cfset LOCAL.error = "{label} is a required field that was skipped.">
			<cfelse>
				<cfset LOCAL.error = "stop">
				<cfif arguments.mutable>
					<!--- stop prevents further rules from processing but doesn't generate an error --->
					<cfset LOCAL.value = arguments.default>
				</cfif>
			</cfif>
		</cfif>
	<cfelseif isStruct( LOCAL.value )>
		<!--- ensure required field has value --->
		<cfif structIsEmpty( LOCAL.value )>
			<cfif arguments.required>
				<cfset LOCAL.error = "{label} is a required field that was skipped.">
			<cfelse>
				<cfset LOCAL.error = "stop">
				<cfif arguments.mutable>
					<!--- stop prevents further rules from processing but doesn't generate an error --->
					<cfset LOCAL.value = arguments.default>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>
