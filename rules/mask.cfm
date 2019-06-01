<!--- Copyright 2010 Imagineering Internet Inc. (imagineer.ca) and Jordan Clark (jclark@imagineeringstuido.com). All rights reserved.
Use of source and redistribution, with or without modification, are prohibited without prior written consent. --->

<cfparam name="arguments.mask" type="string" default="#LOCAL.ruleArg#">
<cfparam name="arguments.maskType" type="string" default="normal">

<cfset LOCAL.hadError = false>
<cfset LOCAL.return = "">

<cfif arguments.maskType IS "strong">

	<cfloop index="LOCAL.x" from="1" to="#len( arguments.mask )#" step="1">
	
		<cfset LOCAL.char = mid( LOCAL.value, LOCAL.x, 1 )>
		<cfset LOCAL.maskChar = mid( arguments.mask, LOCAL.x, 1 )>
	
		<cfswitch expression="#LOCAL.maskChar#">
	
			<cfcase value="9,0" delimiters=",">
				<cfif NOT isNumeric( LOCAL.char )>
					<cfset LOCAL.hadError = true>
					<cfset LOCAL.return &= " A number was expected not [#LOCAL.char#] in position #LOCAL.x#.">
				</cfif>
			</cfcase>
			
			<cfcase value="A">
				<cfif NOT findNoCase( LOCAL.char, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 1 )>
					<cfset LOCAL.hadError = true>
					<cfset LOCAL.return &= " A letter was expected not [#LOCAL.char#] in position #LOCAL.x#.">
				</cfif>
			</cfcase>
	
			<cfcase value="X">
				<cfif NOT isNumeric( LOCAL.char ) AND NOT findNoCase( LOCAL.char, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 1 )>
					<cfset hadError = true>
					<cfset return = return & " An alpha-numeric was expected not [#LOCAL.char#] in position #LOCAL.x#.">
				</cfif>
			</cfcase>
	
			<cfdefaultcase>
				<cfif compareNoCase( LOCAL.maskChar, LOCAL.char ) IS NOT 0>
					<cfset LOCAL.hadError = true>
					<cfset LOCAL.return &= " A [#LOCAL.maskChar#] was expected not [#LOCAL.char#] in position #LOCAL.x#.">
				</cfif>
			</cfdefaultcase>
	
		</cfswitch>
		
	</cfloop>
	
	<cfif LOCAL.hadError>
		<cfset LOCAL.error = "{label} is invalid, #LOCAL.return#">
	</cfif>

<cfelse><!--- normal --->

	<cfloop index="LOCAL.x" from="1" to="#len( arguments.mask )#" step="1">
	
		<cfset LOCAL.char = mid( LOCAL.value, x, 1 )>
		<cfset LOCAL.maskChar = mid( arguments.mask, x, 1 )>
	
		<cfswitch expression="#LOCAL.maskChar#">
	
			<cfcase value="9,0" delimiters=",">
				<cfif NOT findNoCase( LOCAL.char, "0123456789" )>
					<cfset LOCAL.hadError = true>
					<cfbreak>
				</cfif>
			</cfcase>
			
			<cfcase value="A">
				<cfif NOT findNoCase( LOCAL.char, "ABCDEFGHIJKLMNOPQRSTUVWXYZ" )>
					<cfset LOCAL.hadError = true>
					<cfbreak>
				</cfif>
			</cfcase>
	
			<cfcase value="X">
				<cfif NOT findNoCase( LOCAL.char, "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ" )>
					<cfset LOCAL.hadError = true>
					<cfbreak>
				</cfif>
			</cfcase>
	
			<cfdefaultcase>
				<cfif compareNoCase( LOCAL.maskChar, LOCAL.char ) IS NOT 0>
					<cfset LOCAL.hadError = true>
					<cfbreak>
				</cfif>
			</cfdefaultcase>
	
		</cfswitch>
		
	</cfloop>
	
	<cfif LOCAL.hadError>
		<cfset LOCAL.error = "{label} must match the mask ""#arguments.mask#"".">
	</cfif>

</cfif>