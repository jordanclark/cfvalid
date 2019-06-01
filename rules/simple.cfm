<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfif NOT isSimpleValue( LOCAL.value )>
	<cfif arguments.mutable AND arguments.autoFix>
		<cfset LOCAL.value = "">
	</cfif>
	<cfset LOCAL.error = "{label} can only be a simple string value.">
</cfif>

