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
		describe("Basic isValid operations", function(){
			beforeEach(function( currentSpec ) {
				v = new valid( rulePaths= "/rules" );
				testInput = {};
			});
			afterEach( function( currentSpec ) {
				structDelete( variables, "v" );
				structDelete( variables, "testInput" );
			});
			
			it("handles if a variable exists", function(){
				testInput[ "foobar" ] = "exists";
				expect( v.isValid( testInput, "foobar" ) ).toBeTrue();
			});
			it("handles if a variable doesn't exist", function(){
				// testInput[ "foobar" ] = "exists";
				expect( v.isValid( testInput, "foobar" ) ).toBeFalse();
			});
		});
   
   }

}