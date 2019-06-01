<cfset LOCAL.recap = BOOT.service( "recaptcha" ).verify( LOCAL.value )>

<cfif NOT LOCAL.recap.success>
	<cfset LOCAL.error = "Test failed: " & LOCAL.recap.error & " Please try again">
</cfif>
