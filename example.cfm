<cfsetting showdebugoutput="true">
<cfset v = new valid()>

<!--- simulate fake input --->
<cfset URL.pk = "invalid-number">
<cfparam name="FORM.fname" default="Jordan">
<!--- <cfparam name="FORM.mname" default=""> --->
<cfparam name="FORM.lname" default="">
<cfset FORM.color = "purple">
<!--- <cfset FORM.color2 = ""> --->
<!--- <cfset FORM.email = ""> --->
<cfset FORM.toolong = "too long and param validation will autoFix truncate it without throwing an error">

<!--- example invalid URL field --->
<cfset v.urlValidate(
	var= "pk"
,	label= "Account ID"
,	rules= "numeric"
)>
<!--- example field validation is valid --->
<cfset v.formValidate(
	var= "fname"
,	label= "First Name"
,	rules= "simple,html_strict,length:3-50,name"
)>
<!--- example field it never existed in form scope but it is required--->
<cfset v.formValidate(
	var= "mname"
,	label= "Middle Name"
,	rules= "simple,html_strict,length:3-50,name"
)>
<!--- example field is empty but it is required--->
<cfset v.formValidate(
	var= "lname"
,	label= "Last Name"
,	rules= "simple,html_strict,length:3-50,name"
)>
<!--- example field has a list of acceptable values, so the input changed to default --->
<cfset v.formValidate(
	var= "color"
,	label= "Favorite Color"
,	rules= "simple,list"
,	list= "red,blue,green"
,	defaultValue= "blue"
)>
<!--- example field isn't required so even though no value was given it doesn't throw an error, just assigns the default value --->
<cfset v.formValidate(
	var= "color2"
,	label= "Second Color"
,	rules= "simple,list"
,	list= "red,blue,green"
,	defaultValue= "red"
,	required= false
)>
<!--- example email address was valid against multiple rules --->
<cfset v.formValidate(
	var= "email"
,	label= "Email Address"
,	rules= "simple,html_strict,length:6-50,email,not_default"
,	defaultValue= "fred@aol.com"
)>
<!--- example PARAM validation doesn't generate error messages in request.errors for the user to correct --->
<!--- its just a cfparam alternative to safely handle input and auto-fix the values --->
<!--- "param()" isn't required by default --->
<cfset v.formParam( 
	var= "toolong"
,	rules= "length:2-8"
)>

<cfoutput>

<p>All Validations: #request.isValid#</p>

<!--- example displaying all form errors --->
<cfif NOT structIsEmpty( request.errors )>
	<p style="color: red;"><b>There were problems in the information submitted:</b></p>
	<ul style="color: red;">
		<cfloop item="field" collection="#request.errors#">
			<li>#request.errors[ field ]#</li>
		</cfloop>
	</ul>
</cfif>

<form method="POST" action="example.cfm" enctype="application/x-www-form-urlencoded">

<!--- example displaying error by input --->
<div>
	<label for="fname">First Name</label>
	<input type="text" name="fname" value="#form.fname#">
	<cfif structKeyExists( request.errors, "fname" )>
		<div style="color: red;">Error: #request.errors.fname#</div>
	</cfif>
</div>
<div>
	<label for="fname">Middle Name</label>
	<input type="text" name="mname" value="#form.mname#">
	<cfif structKeyExists( request.errors, "mname" )>
		<div style="color: red;">Error: #request.errors.mname#</div>
	</cfif>
</div>
<div>
	<label for="fname">Last Name</label>
	<input type="text" name="lname" value="#form.lname#">
	<cfif structKeyExists( request.errors, "lname" )>
		<div style="color: red;">Error: #request.errors.lname#</div>
	</cfif>
</div>
<div>
	<label for="email">Email Address</label>
	<input type="text" name="email" value="#form.email#">
	<cfif structKeyExists( request.errors, "email" )>
		<div style="color: red;">Error: #request.errors.email#</div>
	</cfif>
</div>

<input type="submit">
</form>

<p>
	Param value: #form.toolong#
</p>

<!--- if field has a defaultValue it will be set --->
<cfdump label="FORM Scope" var="#form#">

<cfdump label="Request Errors" var="#request.errors#">

</cfoutput>