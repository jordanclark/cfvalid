<cfparam name="arguments.dataType" type="string" default="#LOCAL.ruleArg#">

<cfswitch expression="#arguments.dataType#">
	
	<cfcase value="Decimal">
		<cfif NOT isNumeric( LOCAL.value ) OR LOCAL.value LT -10^38+1 OR LOCAL.value GT 10^38-1>
			<cfset LOCAL.error = "{label} is not a valid SQL Decimal">
		</cfif>
	</cfcase>
	<cfcase value="Float">
		<cfif NOT isNumeric( LOCAL.value ) OR LOCAL.value LT -1.79E+308 OR LOCAL.value GT 1.79E+308>
			<cfset LOCAL.error = "{label} is not a valid SQL Float">
		</cfif>
	</cfcase>
	<cfcase value="Real">
		<cfif NOT isNumeric( LOCAL.value ) OR LOCAL.value LT -3.40E+38 OR LOCAL.value GT 3.40E+38>
			<cfset LOCAL.error = "{label} is not a valid SQL Real">
		</cfif>
	</cfcase>
	
	<cfcase value="BigInt">
		<cfif NOT isNumeric( LOCAL.value ) OR LOCAL.value LT -9223372036854775808 OR LOCAL.value GT 9223372036854775807>
			<cfset LOCAL.error = "{label} is not a valid SQL BigInt">
		</cfif>
	</cfcase>
	<cfcase value="Int">
		<cfif NOT isNumeric( LOCAL.value ) OR LOCAL.value LT -2147483648 OR LOCAL.value GT 2147483647>
			<cfset LOCAL.error = "{label} is not a valid SQL Int">
		</cfif>
	</cfcase>
	<cfcase value="SmallInt">
		<cfif NOT isNumeric( LOCAL.value ) OR LOCAL.value LT -32768 OR LOCAL.value GT 32767>
			<cfset LOCAL.error = "{label} is not a valid SQL SmallInt">
		</cfif>
	</cfcase>
	<cfcase value="TinyInt">
		<cfif NOT isNumeric( LOCAL.value ) OR LOCAL.value LT 0 OR LOCAL.value GT 255>
			<cfset LOCAL.error = "{label} is not a valid SQL TinyInt">
		</cfif>
	</cfcase>

	<cfcase value="Money">
		<cfif NOT isNumeric( LOCAL.value ) OR LOCAL.value LT -9223372036854775808 OR LOCAL.value GT 9223372036854775807>
			<cfset LOCAL.error = "{label} is not a valid SQL Money">
		</cfif>
	</cfcase>
	<cfcase value="SmallMoney">
		<cfif NOT isNumeric( LOCAL.value ) OR LOCAL.value LT -214748.3648 OR LOCAL.value GT 214748.3647>
			<cfset LOCAL.error = "{label} is not a valid SQL SmallMoney">
		</cfif>
	</cfcase>
	
	<cfcase value="Numeric">
		<cfif NOT isNumeric( LOCAL.value )>
			<cfset LOCAL.error = "{label} is not a valid SQL Numeric">
		</cfif>
	</cfcase>
	
	<cfcase value="Bit">
		<cfif LOCAL.value IS NOT 0 AND LOCAL.value IS NOT 1>
			<cfset LOCAL.error = "{label} is not a valid SQL Bit">
		</cfif>
	</cfcase>
	
	<cfcase value="DateTime">
		<cfif NOT isDate( LOCAL.value ) OR LOCAL.value LT "{ts '1753-01-01 00:00:00'}" OR LOCAL.value GT "{ts '9999-12-31 23:59:59'}">
			<cfset LOCAL.error = "{label} is not a valid SQL DateTime">
		</cfif>
	</cfcase>
	<cfcase value="SmallDateTime">
		<cfif NOT isDate( LOCAL.value ) OR LOCAL.value LT "{ts '1900-01-01 00:00:00'}" OR LOCAL.value GT "{ts '2079-06-06 23:59:00'}">
			<cfset LOCAL.error = "{label} is not a valid SQL SmallDateTime">
		</cfif>
	</cfcase>
	
	<cfcase value="text">
		<cfparam name="arguments.maxLength" type="numeric" default="2147483647">
		<cfif NOT isSimpleValue( LOCAL.value ) OR len( LOCAL.value ) GT arguments.maxLength>
			<cfset LOCAL.error = "{label} is not a valid SQL Text">
		</cfif>
	</cfcase>
	<cfcase value="NText">
		<cfparam name="arguments.maxLength" type="numeric" default="1073741823">
		<cfif NOT isSimpleValue( LOCAL.value ) OR len( LOCAL.value ) GT arguments.maxLength>
			<cfset LOCAL.error = "{label} is not a valid SQL NText(#arguments.maxLength#)">
		</cfif>
	</cfcase>
	<cfcase value="VarChar">
		<cfparam name="arguments.maxLength" type="numeric" default="8000">
		<cfif NOT isSimpleValue( LOCAL.value ) OR len( LOCAL.value ) GT arguments.maxLength>
			<cfset LOCAL.error = "{label} is not a valid SQL VarChar(#arguments.maxLength#)">
		</cfif>
	</cfcase>
	<cfcase value="NVarChar">
		<cfparam name="arguments.maxLength" type="numeric" default="4000">
		<cfif NOT isSimpleValue( LOCAL.value ) OR len( LOCAL.value ) GT arguments.maxLength>
			<cfset LOCAL.error = "{label} is not a valid SQL NVarChar(#arguments.maxLength#)">
		</cfif>
	</cfcase>
	<cfcase value="Char">
		<cfparam name="arguments.maxLength" type="numeric" default="8000">
		<cfif NOT isSimpleValue( LOCAL.value ) OR len( LOCAL.value ) GT arguments.maxLength>
			<cfset LOCAL.error = "{label} is not a valid SQL Char(#arguments.maxLength#)">
		</cfif>
	</cfcase>
	<cfcase value="NChar">
		<cfparam name="arguments.maxLength" type="numeric" default="4000">
		<cfif NOT isSimpleValue( LOCAL.value ) OR len( LOCAL.value ) GT arguments.maxLength>
			<cfset LOCAL.error = "{label} is not a valid SQL NChar(#arguments.maxLength#)>">
		</cfif>
	</cfcase>
	
</cfswitch>
