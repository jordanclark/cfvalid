<cfparam name="arguments.range" type="string" default="#LOCAL.ruleArg#">
<cfparam name="arguments.rangeType" type="string" default="number">

<cfset range_start = listGetAt( arguments.range, 1, "-" )>
<cfset range_end = listGetAt( arguments.range, 2, "-" )>

<!--- reverse the ranges if they are of opposite values --->
<cfif range_start GT range_end>
	<cfset range_tmp = range_start>
	<cfset range_start = range_end>
	<cfset range_end = range_tmp>
</cfif>

<!--- require one or the other attribute --->
<cfif LOCAL.value LT range_start OR LOCAL.value GT range_end>
	<cfswitch expression="#arguments.rangeType#">
		<cfcase value="dollar">
			<cfset LOCAL.error = "{label} must be within the range of #dollarFormat( range_start )# to #dollarFormat( range_end )#.">
		</cfcase>
		<cfcase value="decimal">
			<cfset LOCAL.error = "{label} must be within the range of #decimalFormat( range_start )# to #decimalFormat( range_end )#.">
		</cfcase>
		<cfcase value="number">
			<cfset LOCAL.error = "{label} must be within the range of #numberFormat( range_start )# to #numberFormat( range_end )#.">
		</cfcase>
		<cfcase value="year">
			<cfset LOCAL.error = "{label} must be within the years #range_start# to #range_end#.">
		</cfcase>
	</cfswitch>
</cfif>

