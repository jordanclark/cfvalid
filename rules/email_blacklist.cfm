
<cfif NOT ( BOOT.crud( "SubscriberBlacklist.Exists" )( email= LOCAL.value ) )>
	<cfset LOCAL.error= "{label} can not be signed up, <i>#xmlFormat( LOCAL.value )#</i> has opted out of email communications from OLDIES.com"
		& "Please <a href='mailto:#app.mail.webmaster#'>Contact Us</a> if you would like to sign up. ">
</cfif>
