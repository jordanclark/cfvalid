<!--- more intuitive naming --->
<cfif NOT structKeyExists( arguments, "lengthUnits" )>
	<cfif listFindNoCase( LOCAL.rulesList, "integer" )
		OR listFindNoCase( LOCAL.rulesList, "number" )
		OR listFindNoCase( LOCAL.rulesList, "dollar" )
		OR listFindNoCase( LOCAL.rulesList, "creditcard" )
		OR listFindNoCase( LOCAL.rulesList, "ean" )
		OR listFindNoCase( LOCAL.rulesList, "upc" )
		OR listFindNoCase( LOCAL.rulesList, "zipcode" )
	>
		<cfset arguments.lengthUnits = "number">
	</cfif>
</cfif>

<cfparam name="arguments.length" type="string" default="#LOCAL.ruleArg#">
<cfparam name="arguments.lengthUnits" type="string" default="character">
<cfparam name="arguments.min" type="string" default="">
<cfparam name="arguments.max" type="string" default="">

<cfif isNumeric( arguments.length )>
	<cfset arguments.min = "">
	<cfset arguments.max = "">
<cfelseif listLen( arguments.length, "-" ) IS 2>
	<cfset arguments.min = replace( listGetAt( arguments.length, 1, "-" ), "N", "" )>
	<cfset arguments.max = replace( listGetAt( arguments.length, 2, "-" ), "N", "" )>
<cfelseif left( arguments.length, 1 ) IS "<">
	<cfset arguments.min = "">
	<cfset arguments.max = replace( arguments.length, "<", "" )>
<cfelseif left( arguments.length, 1 ) IS ">">
	<cfset arguments.min = replace( arguments.length, ">", "" )>
	<cfset arguments.max = "">
</cfif>

<cfset LOCAL.len = len( LOCAL.value )>

<cfif arguments.autoFix AND arguments.mutable AND len( arguments.max ) AND LOCAL.len GT arguments.max>
	<cfset LOCAL.value = left( LOCAL.value, arguments.max )>
	<cfset LOCAL.len = len( LOCAL.value )>
</cfif>

<cfif len( arguments.max ) AND len( arguments.min )>
	<cfif LOCAL.len GT arguments.max OR LOCAL.len LT arguments.min>
		<cfif arguments.mutable>
			<cfset LOCAL.value = left( LOCAL.value, arguments.max )>
		</cfif>
		<cfset LOCAL.error = "{label} must be between #arguments.min#-#arguments.max# #arguments.lengthUnits#s long.">
	</cfif>

<cfelseif len( arguments.max )>
	<cfif LOCAL.len GT arguments.max>
		<cfif arguments.mutable>
			<cfset LOCAL.value = left( LOCAL.value, arguments.max )>
		</cfif>
		<cfif arguments.max IS 1>
			<cfset LOCAL.error = "{label} must be no more than #arguments.max# #arguments.lengthUnits# long.">
		<cfelse>
			<cfset LOCAL.error = "{label} must be no more than #arguments.max# #arguments.lengthUnits#s long.">
		</cfif>
	</cfif>

<cfelseif len( arguments.min )>
	<cfif LOCAL.len LT arguments.min>
		<cfif arguments.min IS 1>
			<cfset LOCAL.error = "{label} must be at least #arguments.min# #arguments.lengthUnits# long.">
		<cfelse>
			<cfset LOCAL.error = "{label} must be at least #arguments.min# #arguments.lengthUnits#s long.">
		</cfif>
	</cfif>

<cfelseif len( arguments.length )>
	<cfif LOCAL.len IS NOT arguments.length>
		<cfif arguments.mutable>
			<cfset LOCAL.value = left( LOCAL.value, arguments.length )>
		</cfif>
		<cfif arguments.min IS 1>
			<cfset LOCAL.error = "{label} must be exactly #arguments.length# #arguments.lengthUnits# long.">
		<cfelse>
			<cfset LOCAL.error = "{label} must be exactly #arguments.length# #arguments.lengthUnits#s long.">
		</cfif>
	</cfif>

<cfelse>
	<!--- NO arguments SPECIFIED --->
	<cfthrow type="#this.throwType#.InvalidArguments"
		message="<b>#arguments.label#</b> does not have any valid arguments, min, max or length must be provided."
	>
</cfif>
