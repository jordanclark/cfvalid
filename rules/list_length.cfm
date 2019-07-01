<cfparam name="arguments.listLength" type="string" default="#LOCAL.ruleArg#">
<cfparam name="arguments.listMin" type="string" default="">
<cfparam name="arguments.listMax" type="string" default="">
<cfparam name="arguments.delimiters" type="string" default=",">

<cfif isNumeric( arguments.listLength )>
	<cfset arguments.listMin = "">
	<cfset arguments.listMax = "">
<cfelseif listLen( arguments.listLength, "-" ) IS 2>
	<cfset arguments.listMin = replace( listGetAt( arguments.listLength, 1, "-" ), "N", "" )>
	<cfset arguments.listMax = replace( listGetAt( arguments.listLength, 2, "-" ), "N", "" )>
<cfelseif left( arguments.listLength, 1 ) IS "<">
	<cfset arguments.listMin = "">
	<cfset arguments.listMax = replace( arguments.listLength, "<", "" )>
<cfelseif left( arguments.listLength, 2 ) IS ">">
	<cfset arguments.listMin = replace( arguments.listLength, ">", "" )>
	<cfset arguments.listMax = "">
</cfif>

<cfset LOCAL.length = listLen( LOCAL.value, arguments.delimiters )>

<cfif len( arguments.listMax ) AND len( arguments.listMin )>
	<cfif LOCAL.length GT arguments.listMax OR LOCAL.length LT arguments.listMin>
		<cfset LOCAL.error = "{label} must be between #arguments.listMin#-#arguments.listMax# items long.">
	</cfif>
<cfelseif len( arguments.listMax )>
	<cfif LOCAL.length GT arguments.listMax>
		<cfset LOCAL.error = "{label} must be no more than #arguments.listMax# items long.">
	</cfif>
<cfelseif len( arguments.listMin )>
	<cfif LOCAL.length LT arguments.listMin>
		<cfset LOCAL.error = "{label} must be at least #arguments.listMin# items long.">
	</cfif>
<cfelseif len( arguments.listLength )>
	<cfif LOCAL.length IS NOT arguments.listLength>
		<cfset LOCAL.error = "{label} must be exactly #arguments.listLength# items long.">
	</cfif>
<cfelse>
	<!--- NO arguments SPECIFIED --->
	<cfthrow type="#this.throwType#.Invalidarguments"
		message="<b>#arguments.label#</b> does not have any valid arguments, 'listMin', 'listMax' or 'listLength' must be provided."
	>
</cfif>

