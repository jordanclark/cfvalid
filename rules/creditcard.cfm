<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.cc_type" type="string" default="">
<cfset arguments.cc_type = left( arguments.cc_type, 1 )>

<cfset LOCAL.cardNum = reReplaceNoCase( LOCAL.value, "[^0-9]", "", "all" )>
<cfset LOCAL.length = len( LOCAL.cardNum )>

<cfif arguments.autoFix AND arguments.mutable>
	<cfset LOCAL.value = LOCAL.cardNum>
</cfif>

<!--- Valid MasterCards are 16 digits, starting with 51,52,53,54,55  --->
<!--- Valid Visas are 13 or 16 digits, starting with 4  --->
<!--- Valid Amex are 15 digits, starting with 34 or 37  --->
<!--- Valid Discover are 16 digits, starting with 6011  --->
<cfif	(	( arguments.cc_type IS "M" )
		AND (	( LOCAL.length IS NOT 16 )
			OR	( NOT reFind( "^5[1-5]", LOCAL.value ) )
			)
		)
	OR	(	( arguments.cc_type IS "V" )
		AND	(	( LOCAL.length IS NOT 13 AND LOCAL.length IS NOT 16 )
			OR	( left(LOCAL.value, 1 ) IS NOT 4 )
			)
		)
	OR	(	( arguments.cc_type IS "A" )
		AND	(	( LOCAL.length IS NOT 15 )
			OR	( NOT reFind( "^(34|37)", LOCAL.value ) )
			)
		)
	OR	(	( arguments.cc_type IS "D" )
		AND	(	( LOCAL.length IS NOT 16 )
			OR	( NOT reFind( "^(6011|622(12[6-9]|1[3-9][0-9]|[2-8][0-9]{2}|9[0-1][0-9]|92[0-5]|64[4-9])|65)", LOCAL.value ) )
			)
		)>
	<!--- end of if statement --->
	<cfset LOCAL.error = "{label} number does not match card type, please verify.">

<cfelse>
	<!--- Start Mod 10 Check --->
	<cfset LOCAL.l = LOCAL.length - 1>
	<cfset LOCAL.m = 2>
	<cfset LOCAL.s = 0>
	
	<cfloop index="LOCAL.i" from="#l#" to="1" step="-1">
		<cfset LOCAL.c = mid( LOCAL.value, LOCAL.i, 1 )>
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

	<cfif LOCAL.s IS NOT right( LOCAL.value, 1 )>
		<cfset LOCAL.error = "{label} number given is incorrect, please verify.">
	</cfif>
</cfif>
