
<cfset LOCAL.emailCheck = app.service( "email" ).emailCheck( LOCAL.value )>
<cfset request.log( "email check!!" )>
<cfset request.log( LOCAL.emailCheck )>

<cfif LOCAL.emailCheck.success AND NOT LOCAL.emailCheck.is_valid>
	<cfset LOCAL.error = "{label} '#xmlFormat( LOCAL.value )#' is not correct, please double check.">
	<cfif len( LOCAL.emailCheck.did_you_mean )>
		<cfset LOCAL.error = "<br /> We think the correct email might be: <b>#LOCAL.emailCheck.did_you_mean#</b>">
	</cfif>
</cfif>
