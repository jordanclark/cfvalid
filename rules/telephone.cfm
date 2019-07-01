<!--- <cfparam name="arguments.exclude" type="boolean" default="true"> --->
<cfparam name="arguments.telephone" type="string" default="#LOCAL.ruleArg#">
<cfparam name="arguments.divider" type="string" default=" ">

<!--- 
809 - Anguilla 
268 - Antigua 
54 - Argentina 
61 - Australia 
43 - Austria 
32 - Belgium 
55 - Brazil 
1 - Canada 
86 - China 
506 - Costa Rica 
45 - Denmark 
809 - Dominican Republic 
358 - Finland 
33 - France 
49 - Germany 
30 - Greece 
1 - Grenada 
852 - Hong Kong 
354 - Iceland 
91 - India 
353 - Ireland 
972 - Israel 
39 - Italy 
876 - Jamaica 
81 - Japan 
352 - Luxembourg 
52 - Mexico 
31 - Netherlands 
64 - New Zealand 
505 - Nicaragua 
47 - Norway 
351 - Portugal 
65 - Singapore 
27 - South Africa 
82 - South Korea 
34 - Spain 
46 - Sweden 
41 - Switzerland 
44 - United Kingdom 
--->

<!---
EXCLUDE
000-000-0000
111-111-1111
222-222-2222
333-333-3333
444-444-4444
555-555-5555
666-666-6666
777-777-7777
888-888-8888
999-999-9999
123-456-7890
012-345-6789
987-654-3210
098-765-4321
111-222-3333
--->

<cfswitch expression="#arguments.telephone#">

	<cfcase value="phoneStrict7">
		<cfif arguments.mutable>
			<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^0-9|#arguments.divider#]", "", "all" )>
		</cfif>
		<cfif NOT reFindNoCase( "^[0-9]{3}#arguments.divider#[0-9]{4}$", LOCAL.value )>
			<cfset LOCAL.error = "{label} must be formatted similar to: 123#arguments.divider#4567.">
		</cfif>
	</cfcase>
	
	<cfcase value="phoneStrict10">
		<cfif arguments.mutable>
			<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^0-9|#arguments.divider#]", "", "all" )>
		</cfif>
		
		<cfif NOT reFindNoCase( "^[0-9]{3}#arguments.divider#[0-9]{3}#arguments.divider#[0-9]{4}$", LOCAL.value )>
			<cfset LOCAL.error = "{label} must be formatted similar to: 123#arguments.divider#456#arguments.divider#7890.">
		</cfif>
	</cfcase>
	
	<cfcase value="us-phone">
		<cfif arguments.mutable>
			<cfset LOCAL.value = udf.phoneFormat( reReplaceNoCase( LOCAL.value, "[^0-9 x#arguments.divider#]", "", "all" ) )>
		</cfif>
		
		<cfif NOT reFindNoCase( "^[0-9]{3}#arguments.divider#[0-9]{3}#arguments.divider#[0-9]{4}( x[0-9]{1,5})?$", LOCAL.value )>
			<cfset LOCAL.error = "{label} must be entered like: 123-456-7890.">
		</cfif>
	</cfcase>
	
	<cfdefaultcase><!---phone--->
		<cfif arguments.mutable>
			<cfset LOCAL.value = reReplaceNoCase( LOCAL.value, "[^0-9|#arguments.divider#]", "", "all" )>
		</cfif>
		
		<cfif NOT reFindNoCase( "^[0-9|#arguments.divider#]{7,12}$", LOCAL.value )>
			<cfset LOCAL.error = "{label} must be between 7 and 12 numbers long.">
		</cfif>
	</cfdefaultcase>
	
</cfswitch>