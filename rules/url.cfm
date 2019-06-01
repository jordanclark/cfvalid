<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfif NOT reFindNoCase( "^http[s]*://(([0-9]{1,3}\.?){4,4}|[a-z|0-9]+([a-z|0-9|-|_|\.]*[a-z|0-9]+)?\.[a-z|0-9]+([a-z|0-9|-|\.]*[a-z|0-9]+)?\.[a-z|0-9]{2,3})([/?&].+)*/?$", LOCAL.value )>
	<cfset LOCAL.error = "{label} is invalid, a website address must be formatted like: http://www.smurfs.com/">
</cfif>

