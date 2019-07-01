<cfset LOCAL.value = lCase( trim( LOCAL.value ) )>

<cfif reFind( "[^a-z0-9:,_-]", LOCAL.value )>
	<cfset LOCAL.error = "Invalid product update.">
</cfif>

<cfif NOT len( LOCAL.error )>
	<cfif listLen( LOCAL.error, "," ) GT 100>
		<cfset LOCAL.error = "Update too large.">
	</cfif>
</cfif>

<cfif NOT len( LOCAL.value )>
	<cfset LOCAL.error = "is empty.">
</cfif>

<cfif NOT len( LOCAL.error )>
	<cfloop list="#LOCAL.value#" index="LOCAL.u" delimiters=",">
		<cfif listLen( LOCAL.u, ":" ) GT 2>
			<cfset LOCAL.error = "Invalid update product number.">
		<cfelseif find( ":", LOCAL.u )>
			<cfset LOCAL.m = listFirst( LOCAL.u, ":" )>
			<cfset LOCAL.v = listLast( LOCAL.u, ":" )>
			<cfif len( LOCAL.m ) LT 3 OR len( LOCAL.m ) GT 6>
				<cfset LOCAL.error = "Invalid update product number.">
				<cfbreak>
			<cfelseif len( LOCAL.v ) IS 0 OR len( LOCAL.v ) GT 6>
				<cfset LOCAL.error = "Invalid update variation number.">
				<cfbreak>
			</cfif>
		<cfelse>
			<cfif len( LOCAL.u ) LT 3 OR len( LOCAL.u ) GT 6>
				<cfset LOCAL.error = "Invalid update product number.">
				<cfbreak>
			</cfif>
		</cfif>
	</cfloop>
</cfif>