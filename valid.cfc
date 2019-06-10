component {

	function init(
		required string rulePaths
	,	string errorScope= "request.errors"
	,	string validVar= "request.isValid"
	,	boolean prefixLabel= true
	,	boolean sentense= true
	,	boolean link= true
	,	string throwType= "Custom.Input.Validation"
	) {
		this.rulePaths= arguments.rulePaths;
		this.errorScope= arguments.errorScope;
		this.throwType= arguments.throwType;
		this.defaults= {
			required= true
		,	mutable= true
		,	trim= true
		,	autoFix= false
		,	default= ""
		,	defaultOnError= true
		,	throwable= false
		,	link= arguments.link
		,	errorClass= "Error"
		,	validVar= arguments.validVar
		,	prefixLabel= arguments.prefixLabel
		,	sentence= arguments.sentense
		,	errorScope= arguments.errorScope
		,	message= "is a required field that was skipped"
		};
		this.magicRules= {};
		this.pathCache= {};
		return this;
	}

	function debugLog(required input) {
		if ( structKeyExists( request, "log" ) && isCustomFunction( request.log ) ) {
			if ( isSimpleValue( arguments.input ) ) {
				request.log( "valid.cfc: " & arguments.input );
			} else {
				request.log( "valid.cfc: (complex type)" );
				request.log( arguments.input );
			}
		} else {
			cftrace( text=( isSimpleValue( arguments.input ) ? arguments.input : "" ), var= arguments.input, category= "valid.cfc", type= "information" );
		}
		return;
	}

	string function rulePath(required string name) {
		arguments.name= listFirst( arguments.name, ":" );
		var found= "";
		if ( structKeyExists( this.pathCache, arguments.name ) ) {
			found= this.pathCache[ arguments.name ];
		} else {
			var path= "";
			for ( path in listToArray( this.rulePaths, ";" ) ) {
				if ( fileExists( expandPath( "#path#/#arguments.name#.cfm" ) ) ) {
					found= "#path#/#arguments.name#.cfm";
					this.pathCache[ arguments.name ]= found;
					break;
				}
			}
		}
		if ( !len( found ) ) {
			throw( message= "Couldn't find validation rule #arguments.name#", type= "#this.throwType#.RuleMissing" );
		}
		return found;
	}

	boolean function anyErrors(string validVar= this.defaults.validVar, errorScope= this.defaults.errorScope) {
		LOCAL.bError= false;
		if ( len( arguments.validVar ) && evaluate( arguments.validVar ) == false ) {
			LOCAL.bError= true;
		} else if ( len( arguments.errorScope ) ) {
			LOCAL.errorScope= ( isSimpleValue( arguments.errorScope ) ? evaluate( arguments.errorScope ) : arguments.errorScope );
			if ( isStruct( LOCAL.errorScope ) && !structIsEmpty( LOCAL.errorScope ) ) {
				LOCAL.bError= true;
			}
		}
		return LOCAL.bError;
	}

	boolean function hadError(required string vars, errorScope= this.defaults.errorScope) {
		LOCAL.bError= false;
		LOCAL.errorScope= ( isSimpleValue( arguments.errorScope ) ? evaluate( arguments.errorScope ) : arguments.errorScope );
		for ( LOCAL.var in listToArray( arguments.vars, ",; " ) ) {
			if ( structKeyExists( LOCAL.errorScope, LOCAL.var ) ) {
				LOCAL.bError= true;
				break;
			}
		}
		this.debugLog( "HadError #arguments.vars#= #LOCAL.bError#" );
		return LOCAL.bError;
	}

	function clearErrors(errorScope= this.defaults.errorScope) {
		return structClear( ( isSimpleValue( arguments.errorScope ) ? evaluate( arguments.errorScope ) : arguments.errorScope ) );
	}

	function addMagicRule(required string name, required string rules) {
		var n= arguments.name;
		structDelete( arguments, "name" );
		this.magicRules[ n ]= arguments;
		return this;
	}

	boolean function isValid(
		required struct scope
	,	required string var
	,	string rules= ""
	,	default= ""
	,	boolean required= true
	,	string trim= true
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	boolean throwable= false
	,	string errorClass= this.defaults.errorClass
	) {
		arguments.throwable= false;
		arguments.errorScope= {};
		arguments.validVar= "";
		arguments.label= "";
		var v= this.validate( argumentCollection= arguments );
		return v.isValid;
	}

	function param(
		required struct scope
	,	required string var
	,	string rules= ""
	,	default= ""
	,	boolean required= false
	,	string trim= true
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	boolean throwable= false
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	) {
		arguments.throwable= false;
		arguments.errorScope= {};
		if ( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		var v= this.validate( argumentCollection= arguments );
		return v.value;
	}

	function params(
		required struct scope
	,	required string vars
	,	string rules= ""
	,	default= ""
	,	boolean required= false
	,	string trim= true
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	boolean throwable= false
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	) {
		arguments.throwable= false;
		arguments.errorScope= {};
		if ( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		if ( find( ",", arguments.vars ) ) {
			for ( arguments.var in listToArray( arguments.vars, ",;" ) ) {
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
	,	default= this.defaults.default
	,	boolean required= this.defaults.required
	,	string trim= this.defaults.trim
	,	boolean autoFix= this.defaults.autoFix
	,	boolean mutable= this.defaults.mutable
	,	boolean defaultOnError= this.defaults.defaultOnError
	,	boolean link= this.defaults.link
	,	boolean throwable= this.defaults.throwable
	,	string errorClass= this.defaults.errorClass
	,	errorScope= this.defaults.errorScope
	,	string validVar= this.defaults.validVar
	,	string error
	) {
		arguments.rules= listPrepend( arguments.rules, "required" );
		structAppend( LOCAL, {
			rule= ""
		,	ruleArg= ""
		,	error= ""
		,	isValid= true
		,	value= nullValue()
		,	rulesList= ""
		,	errorScope= ( isSimpleValue( arguments.errorScope ) ? evaluate( arguments.errorScope ) : arguments.errorScope )
		,	scope= ( isSimpleValue( arguments.scope ) ? evaluate( arguments.scope ) : arguments.scope )
		});
		// apply magic rules 
		for ( LOCAL.rule in listToArray( arguments.rules, "," ) ) {
			if ( structKeyExists( this.magicRules, LOCAL.rule ) ) {
				var mRule= this.magicRules[ listFirst( LOCAL.rule, ':' ) ];
				// apply extra args 
				structAppend( arguments, mRule, true );
				LOCAL.rulesList= listAppend( LOCAL.rulesList, mRule.rules );
				LOCAL.rulesList= listRemoveDuplicates( LOCAL.rulesList, ",", true );
			} else {
				LOCAL.rulesList= listAppend( LOCAL.rulesList, LOCAL.rule );
			}
		}
		// test rules 
		for ( LOCAL.rule in listToArray( LOCAL.rulesList, "," ) ) {
			LOCAL.error= "";
			LOCAL.ruleArg= listRest( LOCAL.rule, ':' );
			LOCAL.file= this.rulePath( LOCAL.rule );
			include LOCAL.file;
			if ( LOCAL.error == "stop" ) {
				// stop processing but don't throw an error 
				break;
			} else if ( len( LOCAL.error ) ) {
				if ( arguments.defaultOnError ) {
					LOCAL.value= arguments.default;
				}
				if ( isNull( LOCAL.value ) || !isSimpleValue( LOCAL.value ) ) {
					this.debugLog( "Failed #arguments.var# '#LOCAL.rule#': #replace( LOCAL.error, '{label}', '', 'all' )# [null/complex]" );
				} else {
					this.debugLog( "Failed #arguments.var# '#LOCAL.rule#': #replace( LOCAL.error, '{label}', '', 'all' )# [#LOCAL.value#]" );
				}
				LOCAL.isValid= false;
				// global error message 
				if ( structKeyExists( arguments, "error" ) && len( arguments.error ) ) {
					LOCAL.error= arguments.error;
				}
				// build the error msg 
				LOCAL.errorMsg= this.formatErrorMessage( LOCAL.error, arguments.label, arguments.errorClass, arguments.link, arguments.var );
				// prepend the existing error if there is one 
				if ( structKeyExists( LOCAL.errorScope, arguments.var ) ) {
					LOCAL.errorMsg= LOCAL.errorScope[ arguments.var ] & chr( 10 ) & LOCAL.errorMsg;
				}
				// store the error, or append it to an existing one 
				LOCAL.errorScope[ arguments.var ]= LOCAL.errorMsg;
				if ( arguments.throwable ) {
					if ( arguments.mutable ) {
						LOCAL.scope[ arguments.var ]= LOCAL.value;
					}
					throw( message= LOCAL.errorMsg, detail= LOCAL.error, type= "Custom.Input.Validation" );
				}
				// end the loop 
				break;
			}
		}
		if ( LOCAL.isValid ) {
			if ( isSimpleValue( arguments.scope ) ) {
				this.debugLog( "Passed #lCase( arguments.scope )#.#arguments.var# '#LOCAL.rulesList#'" );
			} else {
				this.debugLog( "Passed #arguments.var# '#LOCAL.rulesList#'" );
			}
		}
		// update value incase rule updated directly 
		if ( arguments.mutable ) {
			LOCAL.scope[ arguments.var ]= LOCAL.value;
		}
		if ( !LOCAL.isValid && len( arguments.validVar ) ) {
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
	,	errorScope= this.defaults.errorScope
	,	string validVar= this.defaults.validVar
	) {
		arguments.errorScope= ( isSimpleValue( arguments.errorScope ) ? evaluate( arguments.errorScope ) : arguments.errorScope );
		arguments.errorMsg= "";
		if ( !len( arguments.label ) ) {
			arguments.errorMsg= arguments.error;
		} else {
			arguments.errorMsg= this.formatErrorMessage( arguments.error, arguments.label, arguments.errorClass, arguments.link, arguments.var );
		}
		if ( structKeyExists( arguments.errorScope, arguments.var ) ) {
			arguments.errorMsg= arguments.errorScope[ arguments.var ] & chr( 10 ) & arguments.errorMsg;
		}
		this.debugLog( "error #arguments.var#= #arguments.errorMsg#" );
		// store the error, or append it to an existing one 
		arguments.errorScope[ arguments.var ]= arguments.errorMsg;
		// this.debugLog( duplicate( arguments.errorScope ) );
		if ( len( arguments.validVar ) ) {
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
		if ( !len( arguments.label ) ) {
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
		if ( this.defaults.prefixLabel ) {
			if ( !find( "{label}", arguments.message ) ) {
				arguments.message= "{label} " & arguments.message;
			}
			arguments.label= '<b>' & arguments.label & '</b>';
			if ( arguments.link ) {
				arguments.label= '<a href="###arguments.var#" class="#arguments.errorClass#">' & arguments.label & '</a>';
			}
			arguments.message= replace( arguments.message, "{label}", arguments.label, "all" );
		} else {
			arguments.message= trim( replace( arguments.message, "{label}", "", "all" ) );
		}
		if ( this.defaults.sentence && right( arguments.message, 1 ) != "." && right( arguments.message, 1 ) != "!" ) {
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
	,	default= false
	,	string errorClass= this.defaults.errorClass
	) {
		arguments.scope= "FORM";
		arguments.throwable= false;
		arguments.required= false;
		arguments.autoFix= true;
		arguments.trim= true;
		arguments.mutable= true;
		arguments.link= false;
		arguments.errorScope= {};
		arguments.rules= listPrepend( arguments.rules, "simple,submitted" );
		arguments.validVar= "";
		if ( cgi[ 'request_method' ] == "POST" ) {
			arguments.default= true;
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
	,	default= ""
	,	boolean required= true
	,	string trim= true
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	) {
		arguments.scope= "FORM";
		arguments.throwable= false;
		arguments.errorScope= {};
		arguments.validVar= "";
		arguments.label= "";
		if ( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		var v= this.validate( argumentCollection= arguments );
		this.debugLog( "isFormValid? #v.isValid#" );
		return v.isValid;
	}

	function formParam(
		required string var
	,	string rules= ""
	,	default= ""
	,	boolean required= false
	,	string trim= true
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	) {
		arguments.scope= "FORM";
		arguments.throwable= false;
		arguments.errorScope= {};
		if ( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		if ( !arguments.required ) {
			arguments.validVar= "";
		}
		var v= this.validate( argumentCollection= arguments );
		return v.value;
	}

	function formParams(
		required string vars
	,	string rules= ""
	,	default= ""
	,	boolean required= false
	,	string trim= true
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	) {
		arguments.scope= "FORM";
		arguments.throwable= false;
		arguments.errorScope= {};
		if ( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		if ( !arguments.required ) {
			arguments.validVar= "";
		}
		if ( find( ",", arguments.vars ) ) {
			for ( arguments.var in listToArray( arguments.vars, ",;" ) ) {
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
	,	string default= ""
	,	query query
	,	struct defaults= {}
	,	boolean required= false
	,	string trim= true
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	) {
		var standardDefault= arguments.default;
		arguments.hasQuery= ( structKeyExists( arguments, "query" ) && arguments.query.recordCount );
		arguments.scope= "FORM";
		arguments.throwable= false;
		arguments.errorScope= {};
		if ( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		if ( !arguments.required ) {
			arguments.validVar= "";
		}
		for ( arguments.var in listToArray( arguments.vars, ",;" ) ) {
			arguments.default= standardDefault;
			if ( arguments.hasQuery && listFindNoCase( arguments.query.columnList, arguments.var ) ) {
				// this.debugLog( "#arguments.var# Default value from query [#arguments.query[ arguments.var ]#]" );
				arguments.default= arguments.query[ arguments.var ];
			} else if ( structKeyExists( arguments.defaults, arguments.var ) ) {
				// this.debugLog( "#arguments.var# Default value from defaults [#arguments.defaults[ arguments.var ]#]" );
				arguments.default= arguments.defaults[ arguments.var ];
			}
			this.validate( argumentCollection= arguments );
		}
		return;
	}

	function formValidate(
		required string var
	,	string label= arguments.var
	,	string rules= ""
	,	default= this.defaults.default
	,	boolean required= true
	,	string trim= this.defaults.trim
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
		if ( !listFindNoCase( arguments.rules, "simple" ) ) {
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
	,	default= ""
	,	boolean required= true
	,	string trim= true
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	) {
		arguments.scope= "URL";
		arguments.throwable= false;
		arguments.errorScope= {};
		arguments.validVar= "";
		arguments.label= "";
		if ( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		var v= this.validate( argumentCollection= arguments );
		return v.isValid;
	}

	function urlParam(
		required string var
	,	string rules= ""
	,	default= ""
	,	boolean required= false
	,	string trim= true
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	) {
		arguments.scope= "URL";
		arguments.throwable= false;
		arguments.errorScope= {};
		if ( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		if ( !arguments.required ) {
			arguments.validVar= "";
		}
		var v= this.validate( argumentCollection= arguments );
		return v.value;
	}

	function urlParams(
		required string vars
	,	string rules= ""
	,	default= ""
	,	boolean required= false
	,	string trim= true
	,	boolean autoFix= true
	,	boolean mutable= true
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	) {
		arguments.scope= "URL";
		arguments.throwable= false;
		arguments.errorScope= {};
		if ( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		if ( !arguments.required ) {
			arguments.validVar= "";
		}
		if ( find( ",", arguments.vars ) ) {
			for ( arguments.var in listToArray( arguments.vars, ",;" ) ) {
				this.validate( argumentCollection= arguments );
			}
		} else {
			arguments.var= arguments.vars;
			return this.validate( argumentCollection= arguments );
		}
		return;
	}

	function urlValidate(required string var
	,	string label= arguments.var
	,	string rules= ""
	,	default= this.defaults.default
	,	boolean required= true
	,	string trim= this.defaults.trim
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
		if ( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		return this.validate( argumentCollection= arguments );
	}

	// ----------------------------------------------------- 
	// COOKIE SCOPE 
	// ----------------------------------------------------- 

	boolean function isCookieValid(required string var
	,	string rules= ""
	,	default= ""
	,	boolean required= true
	,	string trim= true
	,	boolean autoFix= true
	,	boolean mutable= false
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	) {
		arguments.scope= "COOKIE";
		arguments.throwable= false;
		arguments.errorScope= {};
		arguments.validVar= "";
		arguments.label= "";
		if ( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		var v= this.validate( argumentCollection= arguments );
		return v.isValid;
	}

	function cookieParam(
		required string var
	,	string rules= ""
	,	default= ""
	,	boolean required= false
	,	string trim= true
	,	boolean autoFix= true
	,	boolean mutable= false
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	) {
		if ( !arguments.required ) {
			arguments.validVar= "";
		}
		arguments.scope= "COOKIE";
		arguments.throwable= false;
		arguments.errorScope= {};
		if ( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		var v= this.validate( argumentCollection= arguments );
		return v.value;
	}

	function cookieParams(
		required string vars
	,	string rules= ""
	,	default= ""
	,	boolean required= false
	,	string trim= true
	,	boolean autoFix= true
	,	boolean mutable= false
	,	boolean defaultOnError= true
	,	boolean link= false
	,	string errorClass= this.defaults.errorClass
	,	string validVar= this.defaults.validVar
	) {
		if ( !arguments.required ) {
			arguments.validVar= "";
		}
		arguments.scope= "COOKIE";
		arguments.throwable= false;
		arguments.errorScope= {};
		if ( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		if ( find( ",", arguments.vars ) ) {
			for ( arguments.var in listToArray( arguments.vars, ",;" ) ) {
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
	,	default= this.defaults.default
	,	boolean required= true
	,	string trim= this.defaults.trim
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
		if ( !listFindNoCase( arguments.rules, "simple" ) ) {
			arguments.rules= listPrepend( arguments.rules, "simple" );
		}
		return this.validate( argumentCollection= arguments );
	}

}
