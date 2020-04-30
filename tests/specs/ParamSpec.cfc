component extends="testbox.system.BaseSpec" {

	// executes before all suites
	function beforeAll() {
		request.log= function( input ) {
			debug( arguments.input );
		};
	}

    // executes after all suites
    function afterAll() {
		structDelete( request, "log" );
	}

 	// All suites go in here
	function run( testResults, testBox ){
		describe("Basic Params operations", function(){
			beforeEach(function( currentSpec ) {
				v = new valid(
					rulePaths= "/rules"
				,	defaultValue= "a-default-value"
				);
				testInput = {};
			});
			afterEach( function( currentSpec ) {
				structDelete( variables, "v" );
				structDelete( variables, "testInput" );
			});
			
			it("handles if a variable exists, returns its value", function(){
				testInput[ "foobar" ] = "exists";
				expect( v.param( testInput, "foobar" ) ).toBe( "exists" );
			});
			it("handles if param doesn't exist, returns defaultValue", function(){
				// testInput[ "foobar" ] = "exists";
				expect( v.param( testInput, "foobar" ) ).toBe( "a-default-value" );
			});
			it("handles multiple params together", function(){
				testInput[ "foo1" ] = "exists";
				// testInput[ "foo2" ] = "exists";
				testInput[ "foo3" ] = "exists";
				v.params( testInput, "foo1,foo2,foo3" );
				expect( testInput ).toHaveLength( 3 ).toHaveKey( "foo2" );
			});
			it("handles passing multiple rules", function(){
				testInput[ "foobar" ] = "exists";
				expect( v.param( testInput, "foobar", "simple,string,length:<10,html_safe" ) ).toBe( "exists" );
			});
			it("handles failing multiple rules", function(){
				testInput[ "foobar" ] = "exists";
				expect( v.param( scope= testInput, var= "foobar", rules= "simple,string,length:<3,html_safe", autoFix= false ) ).toBe( "a-default-value" );
			});

			it("handles autofix and mutating original value", function(){
				testInput[ "foobar" ] = "exists";
				expect( v.param( scope= testInput, var= "foobar", rules= "length:<3", autofix= true ) ).toBe( "exi" );
				expect( testInput[ "foobar" ] ).toBe( "exi" );
			});
			it("handles autofix while not-mutating original variable", function(){
				testInput[ "foobar" ] = "exists";
				expect( v.param( scope= testInput, var= "foobar", rules= "length:<3", autofix= true, mutable=false ) ).toBe( "exi" );
				expect( testInput[ "foobar" ] ).toBe( "exists" );
			});

			// forms
			it("handles form params", function(){
				form.foobar = "exists";
				expect( v.formParam( "foobar" ) ).toBe( "exists" );
				structDelete( form, "foobar" );
			});

			// url
			it("handles url params", function(){
				url.foobar = "exists";
				expect( v.urlParam( "foobar" ) ).toBe( "exists" );
				structDelete( url, "foobar" );
			});
		});
   
   }

}