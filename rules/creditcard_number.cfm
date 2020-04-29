<cfset LOCAL.cardNum = reReplaceNoCase( LOCAL.value, "[^0-9]", "", "all" )>
<cfset LOCAL.length = len( LOCAL.cardNum )>

<cfif arguments.autoFix>
	<cfset LOCAL.value = LOCAL.cardNum>
</cfif>

<!--- Start Mod 10 Check --->
<cfset LOCAL.l = LOCAL.length - 1>
<cfset LOCAL.m = 2>
<cfset LOCAL.s = 0>

<cfloop index="LOCAL.i" from="#l#" to="1" step="-1">
	<cfset LOCAL.c = mid( LOCAL.cardNum, LOCAL.i, 1 )>
	<cfset LOCAL.p = LOCAL.m * LOCAL.c>
	<cfif LOCAL.p GT 9>
		<cfset LOCAL.s = LOCAL.s + LOCAL.p - 9>
	<cfelse>
		<cfset LOCAL.s = LOCAL.s + LOCAL.p>
	</cfif>
	<cfset LOCAL.m = 3 - LOCAL.m>
</cfloop>

<cfset LOCAL.s = LOCAL.s MOD 10>
<cfif LOCAL.s IS NOT 0>
	<cfset LOCAL.s = 10 - LOCAL.s>
</cfif>

<cfif LOCAL.s IS NOT right( LOCAL.cardNum, 1 )>
	<cfset LOCAL.error = "{label} number given is incorrect, please verify.">
</cfif>
