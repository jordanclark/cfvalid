<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfif NOT isBinary( LOCAL.value )>
	<cfset LOCAL.error = "{label} is not a valid binary object.">
</cfif>

