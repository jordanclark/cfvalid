```
        __               _  _      _ 
  ___  / _|__   __ __ _ | |(_)  __| |
 / __|| |_ \ \ / // _` || || | / _` |
| (__ |  _| \ V /| (_| || || || (_| |
 \___||_|    \_/  \__,_||_||_| \__,_|
                                     
```
[![Build Status](https://travis-ci.com/jordanclark/cfvalid.svg?branch=master)](https://travis-ci.com/jordanclark/cfvalid)

# cfvalid
CF Input validation made awesome! (and safe)

cfvalid includes validation rules for 90+ validation rules, and custom rules are very easy to create in a few lines of code.

Some rules will massage data and automatically correct values if possible, for example "zipcode" can automatically stip out any non-numeric
values, and if the result is valid no error is thrown.

# Main Validation Options

## Common Arguments
* `var=string` - variable name
* `vars=list` - list of variable names for params functions
* `rules=list` - list of rules to check in order, example: "simple,length:1-10,numeric" some rules like "length" can be passed a shorthand argument after the colon, but rules can define their own custom arguments
* `required=bool` - if a required variable doesn't exist in the scope it throws an error, isvalid & validate defaults to required=true, param defaults to required=false
* `scope=struct` - the structure holding the variable, useful for custom scopes, otherwise use the form/url/cookie convenience methods
* `label=string` - field name to display in error messages
* `autoFix=bool` - some rules may attempt to auto fix input to be valid
* `mutable=bool` - if rules can update the original variable
* `throwable=bool` - defaults to false, this will make any validation error throw a cfthrow exception that can be caught by error handling
```
valid.param( scope=form, var="test", rule="length:1-10" );
valid.param( scope=form, var="test", rule="length", min=1, max=10 );
valid.param( scope=request, var="foo", rule="boolean", default= false );
```

## validate()
#### formValidate() / urlValidate() / cookieValidate()
Checks if a variable is valid against a list of customizable rules, error messages are added to a errorStruct (default request.errors)
```
valid.formValidate( var="name", label="Name", rules="string,length:<50" );
valid.formValidate( var="email", label="Email Address", rules="string,email,length:5-75" );
valid.validate( scope=cfc.person, var="name", label="Person Name", rules="string,length:<50", mutable= false );
```

## param() or params()
#### formParam() / formParams() / urlParam() / urlParams() / cookieParam() / cookieParams()
Checks if a variable is valid against a list of customizable rules, defaults to not required, returns no error messages, just useful for
safely handling variables, similar but better than cfparam.
```
valid.param( scope=request, var="test", rules="boolean", default=false );
valid.urlParams( vars="fname,mname,lname", rules="string,html_safe", default="" );
```

## isValid()
#### isFormValid() / isUrlValid() / isCookieValid()
Checks if a variable is valid against a list of customizable rules, and returns true/false.
```
<cfif valid.isValid( scope=form, var="name", rules= "string,length:<50" )> ... </cfif>
<cfif valid.isFormValid( "name", "String,length:<50" )> ... </cfif>
```

### error() 
If you want to create an error message without processing any rules
```
valid.error( var="email", error="This email address already exists in our system" );
```

### anyErrors()
Check the error struct has any error messages in it.

### hadError()
Check if one of the vars exists in the error struct.

## Some of the most useful rules
* `required` - special rule that is always checked first, this checks if the variable even exists in the scope, and if not stops processing any additional rules
* `simple` - good to always check that user input is a string
* `length` - makes sure strings aren't too long or too short (shorthand length:min-max or length:<max or length:>min)
* `email` - Email address validation, with different error messages for different missing parts
* `list` - Compares the input to a list of acceptable values, includes options for multiple values and delims
* `range` - Validates a number is within a range (shorthand range:min-max)
* `not_default` - Validates that the input isn't the default value
* `html_safe` - Removes unsafe html tags
* `html_strict` - Removes all html tags
* `sql_safe` - Removes common sql keywords and exploit syntax
* `multiple` - Special rule that applies validation to each item in the list or array (like multiple:integer would validate "1,2,3" is valid but not "1,B,3")

## addComboRule()
I've found I often come up with combo validation rules that I reuse over and over, so this is a way to name a rule which applies several rules and arguments more easily.
For example on init, add the combo:
```
valid.addComboRule(
	name= "email_group"
,	rules= "simple,html_strict,length:6-50,email"
,	label= "Email Address"
);
```
Then just apply it like a normal single rule:
```
valid.formValidate( var= "email", rules= "email_group" );
```

## Custom Rule Example
Place new rules in the /rules folder (or add another folder to the init "rulePaths"), then check LOCAL.value against your rule, if there is a problem set LOCAL.error= "bad things happened". You can also add your own custom arguments, just try and make their names unique
```
<cfparam name="arguments.example" type="boolean" default="true">
<cfif arguments.example AND NOT isSimpleValue( LOCAL.value )>
	<cfset LOCAL.error = "{label} failed the example rule">
</cfif>
```

## To Install
Run the following from commandbox:
```
box install cfvalid
```

## Run Tests
Install testbox
```
box install
box testbox run
```

## Changes
* 2020-04-30 Travis multi-engine test support
* 2020-04-29 Testbox BDD Specs
* 2020-04-24 Docs and some fixes
* 2019-06-03 Open source release
