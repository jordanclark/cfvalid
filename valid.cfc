component {

	/**
	 * Init
	 *
	 * @rulePaths include path to include rules from 1 or more directors
	 * @errorStruct var name of struct where error messages are put from validate() type functions
	 * @validVar var name of bool which indicates a validation error
	 * @prefixLabel if the field label should be prefixed to error messages
	 * @sentence if error messages should be sentences
	 * @link if error messages should link to the form field
	 * @throwType the custom type of throwable errors
	 * @defaults default values used for most validation functions
	 */
	function init(
		string rulePaths= "./rules"
	,	string errorStruct= "request.errors"
	,	string validVar= "request.isValid"
	,	boolean prefixLabel= true
	,	boolean sentence= true
	,	boolean link= true
	,	string throwType= "Custom.Input.Validation"
	,	struct defaults= {}
	) {
		this.rulePaths= arguments.rulePaths;
		this.errorStruct= arguments.errorStruct;
		this.throwType= arguments.throwType;
		structAppend( arguments.defaults, {
			required= true
		,	mutable= true
		,	autoFix= false
		,	defaultValue= ""
		,	defaultOnError= true
		,	throwable= false
		,	link= arguments.link
		,	errorClass= "Error"
		,	validVar= arguments.validVar
		,	prefixLabel= arguments.prefixLabel
		,	sentence= arguments.sentence
		,	errorStruct= arguments.errorStruct
		,	message= "is a required field that was skipped"
		}, false );
		this.defaults= arguments.defaults;
		this.comboRules= {};
		this.pathCache= {};
		return this;
	}

	function debugLog(required input) {
		if( structKeyExists( request, "log" ) && isCustomFunction( request.log ) ) {
			if( isSimpleValue( arguments.input ) ) {
				request.log( "valid.cfc: " & arguments.input );
			} else {
				request.log( "valid.cfc: (complex type)" );
				request.log( arguments.input );
			}
		} else {
			var info= ( isSimpleValue( arguments.input ) ? arguments.input : serializeJson( arguments.input ) );
			cftrace(
				var= "info"
			,	category= "valid.cfc"
			,	type= "information"
			);
		}
		return;
	}

	string function rulePath(required string name) {
		arguments.name= listFirst( arguments.name, ":" );
		var found= "";
		if( structKeyExists( this.pathCache, arguments.name ) ) {
			found= this.pathCache[ arguments.name ];
		} else {
			for( var path in listToArray( this.rulePaths, ";" ) ) {
				if( fileExists( expandPath( "#path#/#arguments.name#.cfm" ) ) ) {
					found= "#path#/#arguments.name#.cfm";
					this.pathCache[ arguments.name ]= found;
					break;
				}
			}
		}
		if( !len( found ) ) {
			throw( message= "Couldn't find validation rule #arguments.name#", type= "#this.throwType#.RuleMissing" );
		}
		return found;
	}

	/**
	 * Check the error struct has any error messages in it.
	 *
	 * @validVar var name
	 * @errorStruct var name
	 */
	boolean function anyErrors(string validVar= this.defaults.validVar, errorStruct= this.defaults.errorStruct) {
		LOCAL.bError= false;
		if( len( arguments.validVar ) && evaluate( arguments.validVar ) == false ) {
			LOCAL.bError= true;
		} else if( len( arguments.errorStruct ) ) {
			LOCAL.errorStruct= ( isSimpleValue( arguments.errorStruct ) ? evaluate( arguments.errorStruct ) : arguments.errorStruct );
			if( isStruct( LOCAL.errorStruct ) && !structIsEmpty( LOCAL.errorStruct ) ) {
				LOCAL.bError= true;
			}
		}
		return LOCAL.bError;
	}

	/**
	 * Check if one of the vars exists in the error struct
	 *
	 * @vars 
	 * @errorStruct 
	 */
	boolean function hadError(required string vars, errorStruct= this.defaults.errorStruct) {
		LOCAL.bError= false;
		LOCAL.errorStruct= ( isSimpleValue( arguments.errorStruct ) ? evaluate( arguments.errorStruct ) : arguments.errorStruct );
		for( LOCAL.var in listToArray( arguments.vars, ",; " ) ) {
			if( structKeyExists( LOCAL.errorStruct, LOCAL.var ) ) {
				LOCAL.bError= true;
				break;
			}
		}
		this.debugLog( "HadError #arguments.vars#= #LOCAL.bError#" );
		return LOCAL.bError;
	}

	function clearErrors(errorStruct= this.defaults.errorStruct) {
		return structClear( ( isSimpleValue( arguments.errorStruct ) ? evaluate( arguments.errorStruct ) : arguments.errorStruct ) );
	}

	function addComboRule(required string name, required string rules) {
		var n= arguments.name;
		structDelete( arguments, "name" );
		this.comboRules[ n ]= arguments;
		return this;
	}

	boolean function isValid(
		required struct scope
	,	required string var
	,	string rules= ""
	,	defaultValue= ""
	,	boolean required= true
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	boolean throwable= false
	,	string errorClass= this.defaults.errorClass
	) {
		arguments.throwable= false;
		arguments.errorStruct= {};
		arguments.validVar= "";
		arguments.label= "";
		var v= this.validate( argumentCollection= arguments );
		return v.isValid;
	}

	function param(
		required struct scope
	,	required string var
	,	string rules= ""
	,	defaultValue= ""
	,	boolean required= false
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	boolean throwable= false
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	,	struct errorStruct= {}
	) {
		arguments.throwable= false;
		if( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		var v= this.validate( argumentCollection= arguments );
		return v.value;
	}

	function params(
		required struct scope
	,	required string vars
	,	string rules= ""
	,	defaultValue= ""
	,	boolean required= false
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	boolean throwable= false
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	,	struct errorStruct= {}
	) {
		arguments.throwable= false;
		if( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		if( find( ",", arguments.vars ) ) {
			for( arguments.var in listToArray( arguments.vars, ",;" ) ) {
				this.validate( argumentCollection= arguments );
			}
		} else {
			arguments.var= arguments.vars;
			return this.validate( argumentCollection= arguments );
		}
		return;
	}

	function validate(
		required scope
	,	required string var
	,	string label= arguments.var
	,	required string rules
	,	defaultValue= this.defaults.defaultValue
	,	boolean required= this.defaults.required
	,	boolean autoFix= this.defaults.autoFix
	,	boolean mutable= this.defaults.mutable
	,	boolean defaultOnError= this.defaults.defaultOnError
	,	boolean link= this.defaults.link
	,	boolean throwable= this.defaults.throwable
	,	string errorClass= this.defaults.errorClass
	,	errorStruct= this.defaults.errorStruct
	,	string validVar= this.defaults.validVar
	,	string error
	) {
		arguments.rules= listPrepend( arguments.rules, "required" );
		structAppend( LOCAL, {
			rule= ""
		,	ruleArg= ""
		,	error= ""
		,	isValid= true
		,	value= javaCast( "null", 0 )
		,	rulesList= ""
		,	errorStruct= {}
		,	scope= ( isSimpleValue( arguments.scope ) ? evaluate( arguments.scope ) : arguments.scope )
		});
		if( isStruct( arguments.errorStruct ) ) {
			LOCAL.errorStruct= arguments.errorStruct;
		} else if( isSimpleValue( arguments.errorStruct ) && len( arguments.errorStruct ) ) {
			if( !isDefined( arguments.errorStruct ) ) {
				"#arguments.errorStruct#"= {};
			}
			LOCAL.errorStruct= evaluate( arguments.errorStruct );
		}
		// apply combo rules 
		for( LOCAL.rule in listToArray( arguments.rules, "," ) ) {
			if( structKeyExists( this.comboRules, LOCAL.rule ) ) {
				var mRule= this.comboRules[ listFirst( LOCAL.rule, ':' ) ];
				// apply extra args 
				structAppend( arguments, mRule, true );
				LOCAL.rulesList= listAppend( LOCAL.rulesList, mRule.rules );
				LOCAL.rulesList= listRemoveDuplicates( LOCAL.rulesList, ",", true );
			} else {
				LOCAL.rulesList= listAppend( LOCAL.rulesList, LOCAL.rule );
			}
		}
		// test rules 
		for( LOCAL.rule in listToArray( LOCAL.rulesList, "," ) ) {
			LOCAL.error= "";
			LOCAL.ruleArg= listRest( LOCAL.rule, ':' );
			LOCAL.file= this.rulePath( LOCAL.rule );
			include LOCAL.file;
			if( LOCAL.error == "stop" ) {
				// stop processing but don't throw an error 
				break;
			} else if( len( LOCAL.error ) ) {
				if( arguments.defaultOnError ) {
					LOCAL.value= arguments.defaultValue;
				}
				if( isNull( LOCAL.value ) || !isSimpleValue( LOCAL.value ) ) {
					this.debugLog( "Failed #arguments.var# '#LOCAL.rule#': #replace( LOCAL.error, '{label}', '', 'all' )# [null/complex]" );
				} else {
					this.debugLog( "Failed #arguments.var# '#LOCAL.rule#': #replace( LOCAL.error, '{label}', '', 'all' )# [#LOCAL.value#]" );
				}
				LOCAL.isValid= false;
				// global error message 
				if( structKeyExists( arguments, "error" ) && len( arguments.error ) ) {
					LOCAL.error= arguments.error;
				}
				// build the error msg 
				LOCAL.errorMsg= this.formatErrorMessage( LOCAL.error, arguments.label, arguments.errorClass, arguments.link, arguments.var );
				// prepend the existing error if there is one 
				if( structKeyExists( LOCAL.errorStruct, arguments.var ) ) {
					LOCAL.errorMsg= LOCAL.errorStruct[ arguments.var ] & chr( 10 ) & LOCAL.errorMsg;
				}
				// store the error, or append it to an existing one 
				LOCAL.errorStruct[ arguments.var ]= LOCAL.errorMsg;
				if( arguments.throwable ) {
					if( arguments.mutable ) {
						LOCAL.scope[ arguments.var ]= LOCAL.value;
					}
					throw( message= LOCAL.errorMsg, detail= LOCAL.error, type= "Custom.Input.Validation" );
				}
				// end the loop 
				break;
			}
		}
		if( LOCAL.isValid ) {
			if( isSimpleValue( arguments.scope ) ) {
				this.debugLog( "Passed #lCase( arguments.scope )#.#arguments.var# '#LOCAL.rulesList#'" );
			} else {
				this.debugLog( "Passed #arguments.var# '#LOCAL.rulesList#'" );
			}
		}
		// update value incase rule updated directly 
		if( arguments.mutable ) {
			LOCAL.scope[ arguments.var ]= LOCAL.value;
		}
		if( !LOCAL.isValid && len( arguments.validVar ) ) {
			"#arguments.validVar#"= false;
			this.debugLog( "#arguments.validVar#= false" );
		}
		return LOCAL;
	}

	function error(
		required string var
	,	required string error
	,	string label= ""
	,	boolean link= this.defaults.link
	,	string errorClass= this.defaults.errorClass
	,	errorStruct= this.defaults.errorStruct
	,	string validVar= this.defaults.validVar
	) {
		arguments.errorStruct= ( isSimpleValue( arguments.errorStruct ) ? evaluate( arguments.errorStruct ) : arguments.errorStruct );
		arguments.errorMsg= "";
		if( !len( arguments.label ) ) {
			arguments.errorMsg= arguments.error;
		} else {
			arguments.errorMsg= this.formatErrorMessage( arguments.error, arguments.label, arguments.errorClass, arguments.link, arguments.var );
		}
		if( structKeyExists( arguments.errorStruct, arguments.var ) ) {
			arguments.errorMsg= arguments.errorStruct[ arguments.var ] & chr( 10 ) & arguments.errorMsg;
		}
		this.debugLog( "error #arguments.var#= #arguments.errorMsg#" );
		// store the error, or append it to an existing one 
		arguments.errorStruct[ arguments.var ]= arguments.errorMsg;
		// this.debugLog( duplicate( arguments.errorStruct ) );
		if( len( arguments.validVar ) ) {
			"#arguments.validVar#"= false;
			this.debugLog( "#arguments.validVar#= false" );
		}
		return arguments;
	}

	function throwError(
		required string var
	,	required string error
	,	string label= ""
	,	boolean link= this.defaults.link
	,	string errorClass= this.defaults.errorClass
	) {
		var errorMsg= "";
		if( !len( arguments.label ) ) {
			errorMsg= arguments.error;
		} else {
			errorMsg= this.formatErrorMessage( arguments.error, arguments.label, arguments.errorClass, arguments.link, arguments.var );
		}
		throw( message= errorMsg, type= "Custom.Input.Validation" );
	}

	string function formatErrorMessage(
		required string message
	,	required string label
	,	required string errorClass
	,	boolean link= false
	,	string var= ""
	) {
		if( this.defaults.prefixLabel ) {
			if( !find( "{label}", arguments.message ) ) {
				arguments.message= "{label} " & arguments.message;
			}
			arguments.label= '<b>' & arguments.label & '</b>';
			if( arguments.link ) {
				arguments.label= '<a href="###arguments.var#" class="#arguments.errorClass#">' & arguments.label & '</a>';
			}
			arguments.message= replace( arguments.message, "{label}", arguments.label, "all" );
		} else {
			arguments.message= trim( replace( arguments.message, "{label}", "", "all" ) );
		}
		if( this.defaults.sentence && right( arguments.message, 1 ) != "." && right( arguments.message, 1 ) != "!" ) {
			arguments.message &= ".";
		}
		return arguments.message;
	}
	
	// ----------------------------------------------------- 
	// FORM SCOPE 
	// ----------------------------------------------------- 

	function formSubmitted(
		string var= "submit"
	,	string rules= ""
	,	defaultValue= false
	,	string errorClass= this.defaults.errorClass
	) {
		arguments.scope= "FORM";
		arguments.throwable= false;
		arguments.required= false;
		arguments.autoFix= true;
		arguments.mutable= true;
		arguments.link= false;
		arguments.errorStruct= {};
		arguments.rules= listPrepend( arguments.rules, "simple,submitted" );
		arguments.validVar= "";
		if( cgi[ 'request_method' ] == "POST" ) {
			arguments.defaultValue= true;
		}
		request.log( "METHOD: [#cgi[ 'request_method' ]#] #( cgi.request_method == 'POST' )#" );
		arguments.defaultOnError= true;
		// request.log( duplicate( cgi ) );
		// request.log( duplicate( arguments ) );
		var v= this.validate( argumentCollection= arguments );
		return v.value;
	}

	boolean function isFormValid(
		required string var
	,	string rules= ""
	,	defaultValue= ""
	,	boolean required= true
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	) {
		arguments.scope= "FORM";
		arguments.throwable= false;
		arguments.errorStruct= {};
		arguments.validVar= "";
		arguments.label= "";
		if( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		var v= this.validate( argumentCollection= arguments );
		this.debugLog( "isFormValid? #v.isValid#" );
		return v.isValid;
	}

	function formParam(
		required string var
	,	string rules= ""
	,	defaultValue= ""
	,	boolean required= false
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	,	struct errorStruct= {}
	) {
		arguments.scope= "FORM";
		arguments.throwable= false;
		if( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		if( !arguments.required ) {
			arguments.validVar= "";
		}
		var v= this.validate( argumentCollection= arguments );
		return v.value;
	}

	function formParams(
		required string vars
	,	string rules= ""
	,	defaultValue= ""
	,	boolean required= false
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	,	struct errorStruct= {}
	) {
		arguments.scope= "FORM";
		arguments.throwable= false;
		if( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		if( !arguments.required ) {
			arguments.validVar= "";
		}
		if( find( ",", arguments.vars ) ) {
			for( arguments.var in listToArray( arguments.vars, ",;" ) ) {
				this.validate( argumentCollection= arguments );
			}
		} else {
			arguments.var= arguments.vars;
			return this.validate( argumentCollection= arguments );
		}
		return;
	}

	function formQueryParams(
		required string vars
	,	string rules= ""
	,	string defaultValue= ""
	,	query query
	,	struct defaults= {}
	,	boolean required= false
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	,	struct errorStruct= {}
	) {
		var standardDefault= arguments.defaultValue;
		arguments.hasQuery= ( structKeyExists( arguments, "query" ) && arguments.query.recordCount );
		arguments.scope= "FORM";
		arguments.throwable= false;
		if( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		if( !arguments.required ) {
			arguments.validVar= "";
		}
		for( arguments.var in listToArray( arguments.vars, ",;" ) ) {
			arguments.defaultValue= standardDefault;
			if( arguments.hasQuery && listFindNoCase( arguments.query.columnList, arguments.var ) ) {
				// this.debugLog( "#arguments.var# Default value from query [#arguments.query[ arguments.var ]#]" );
				arguments.defaultValue= arguments.query[ arguments.var ];
			} else if( structKeyExists( arguments.defaults, arguments.var ) ) {
				// this.debugLog( "#arguments.var# Default value from defaults [#arguments.defaults[ arguments.var ]#]" );
				arguments.defaultValue= arguments.defaults[ arguments.var ];
			}
			this.validate( argumentCollection= arguments );
		}
		return;
	}

	function formValidate(
		required string var
	,	string label= arguments.var
	,	string rules= ""
	,	defaultValue= this.defaults.defaultValue
	,	boolean required= true
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= this.defaults.link
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	,	string error
	) {
		arguments.scope= "FORM";
		arguments.throwable= false;
		if( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		return this.validate( argumentCollection= arguments );
	}

	// ----------------------------------------------------- 
	// URL SCOPE 
	// ----------------------------------------------------- 

	boolean function isUrlValid(
		required string var
	,	string rules= ""
	,	defaultValue= ""
	,	boolean required= true
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	) {
		arguments.scope= "URL";
		arguments.throwable= false;
		arguments.errorStruct= {};
		arguments.validVar= "";
		arguments.label= "";
		if( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		var v= this.validate( argumentCollection= arguments );
		return v.isValid;
	}

	function urlParam(
		required string var
	,	string rules= ""
	,	defaultValue= ""
	,	boolean required= false
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	,	struct errorStruct= {}
	) {
		arguments.scope= "URL";
		arguments.throwable= false;
		if( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		if( !arguments.required ) {
			arguments.validVar= "";
		}
		var v= this.validate( argumentCollection= arguments );
		return v.value;
	}

	function urlParams(
		required string vars
	,	string rules= ""
	,	defaultValue= ""
	,	boolean required= false
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	,	struct errorStruct= {}
	) {
		arguments.scope= "URL";
		arguments.throwable= false;
		if( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		if( !arguments.required ) {
			arguments.validVar= "";
		}
		if( find( ",", arguments.vars ) ) {
			for( arguments.var in listToArray( arguments.vars, ",;" ) ) {
				this.validate( argumentCollection= arguments );
			}
		} else {
			arguments.var= arguments.vars;
			return this.validate( argumentCollection= arguments );
		}
		return;
	}

	function urlValidate(
		required string var
	,	string label= arguments.var
	,	string rules= ""
	,	defaultValue= this.defaults.defaultValue
	,	boolean required= true
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= this.defaults.link
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	,	string error
	) {
		arguments.scope= "URL";
		arguments.throwable= false;
		if( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		return this.validate( argumentCollection= arguments );
	}

	// ----------------------------------------------------- 
	// COOKIE SCOPE 
	// ----------------------------------------------------- 

	boolean function isCookieValid(
		required string var
	,	string rules= ""
	,	defaultValue= ""
	,	boolean required= true
	,	boolean autoFix= true
	,	boolean mutable= false
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	) {
		arguments.scope= "COOKIE";
		arguments.throwable= false;
		arguments.errorStruct= {};
		arguments.validVar= "";
		arguments.label= "";
		if( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		var v= this.validate( argumentCollection= arguments );
		return v.isValid;
	}

	function cookieParam(
		required string var
	,	string rules= ""
	,	defaultValue= ""
	,	boolean required= false
	,	boolean autoFix= true
	,	boolean mutable= false
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	,	struct errorStruct= {}
	) {
		if( !arguments.required ) {
			arguments.validVar= "";
		}
		arguments.scope= "COOKIE";
		arguments.throwable= false;
		if( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		var v= this.validate( argumentCollection= arguments );
		return v.value;
	}

	function cookieParams(
		required string vars
	,	string rules= ""
	,	defaultValue= ""
	,	boolean required= false
	,	boolean autoFix= true
	,	boolean mutable= false
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	,	struct errorStruct= {}
	) {
		if( !arguments.required ) {
			arguments.validVar= "";
		}
		arguments.scope= "COOKIE";
		arguments.throwable= false;
		if( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		if( find( ",", arguments.vars ) ) {
			for( arguments.var in listToArray( arguments.vars, ",;" ) ) {
				this.validate( argumentCollection= arguments );
			}
		} else {
			arguments.var= arguments.vars;
			return this.validate( argumentCollection= arguments );
		}
		return;
	}

	function cookieValidate(
		required string var
	,	string label= arguments.var
	,	string rules= ""
	,	defaultValue= this.defaults.defaultValue
	,	boolean required= true
	,	boolean autoFix= true
	,	boolean mutable= false
	,	boolean defaultOnError= true
	,	boolean link= this.defaults.link
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	,	string error
	) {
		arguments.scope= "COOKIE";
		arguments.throwable= false;
		if( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		return this.validate( argumentCollection= arguments );
	}

}
