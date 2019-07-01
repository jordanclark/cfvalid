<cfparam name="arguments.length" type="string" default="#LOCAL.ruleArg#">
<cfparam name="arguments.min" type="string" default="">
<cfparam name="arguments.max" type="string" default="">

<cfif isNumeric( arguments.length )>
	<cfset arguments.min = "">
	<cfset arguments.max = "">
<cfelseif listLen( arguments.length, "-" ) IS 2>
	<cfset arguments.min = replace( listGetAt( arguments.length, 1, "-" ), "N", "" )>
	<cfset arguments.max = replace( listGetAt( arguments.length, 2, "-" ), "N", "" )>
</cfif>

<cfset LOCAL.length = arrayLen( LOCAL.value )>

<cfif len( arguments.max ) AND len( arguments.min )>
	<cfif LOCAL.length GT arguments.max OR LOCAL.length LT arguments.min>
		<cfset LOCAL.error = "{label} must be between #arguments.min#-#arguments.max# characters long.">
	</cfif>
<cfelseif len( arguments.max )>
	<cfif LOCAL.length GT arguments.max>
		<cfset LOCAL.error = "{label} must be no more than #arguments.max# characters long.">
	</cfif>
<cfelseif len( arguments.min )>
	<cfif LOCAL.length LT arguments.min>
		<cfset LOCAL.error = "{label} must be at least #arguments.min# characters long.">
	</cfif>
<cfelseif len( arguments.length )>
	<cfif LOCAL.length IS NOT arguments.length>
		<cfset LOCAL.error = "{label} must be exactly #arguments.length# characters long.">
	</cfif>
<cfelse>
	<!--- NO arguments SPECIFIED --->
	<cfthrow type="#this.throwType#.InvalidArguments"
		message="<b>#arguments.label#</b> does not have any valid arguments, 'min', 'max' or 'length' must be provided."
	>
</cfif>

