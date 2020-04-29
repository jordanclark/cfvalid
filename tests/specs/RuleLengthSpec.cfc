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
		describe("Test rule LENGTH operations", function(){
			beforeEach(function( currentSpec ) {
				v = new valid(
					rulePaths= "/rules"
				,	defaultValue= "a-default-value"
				,	defaultMutable= true
				,	defaultIsValidAutoFix= false
				);
				testInput = {};
			});
			afterEach( function( currentSpec ) {
				structDelete( variables, "v" );
				structDelete( variables, "testInput" );
			});
			
			it("handles too short", function(){
				testInput[ "foobar" ] = "exists";
				expect( v.isValid( scope= testInput, var= "foobar", rules= "length:<3" ) ).toBeFalse();
			});
			it("handles too long", function(){
				testInput[ "foobar" ] = "exists";
				expect( v.isValid( scope= testInput, var= "foobar", rules= "length:>30" ) ).toBeFalse();
			});
			it("handles not in length range", function(){
				testInput[ "foobar" ] = "exists";
				expect( v.isValid( scope= testInput, var= "foobar", rules= "length:10-20" ) ).toBeFalse();
			});

			it("handles long enough", function(){
				testInput[ "foobar" ] = "exists";
				expect( v.isValid( scope= testInput, var= "foobar", rules= "length:>3" ) ).toBeTrue();
			});
			it("handles short enough", function(){
				testInput[ "foobar" ] = "exists";
				expect( v.isValid( scope= testInput, var= "foobar", rules= "length:<30" ) ).toBeTrue();
			});
			it("handles in length range", function(){
				testInput[ "foobar" ] = "exists";
				expect( v.isValid( scope= testInput, var= "foobar", rules= "length:1-10" ) ).toBeTrue();
			});
			it("handles trimming too long", function(){
				testInput[ "foobar" ] = "exists";
				expect( v.isValid( scope= testInput, var= "foobar", rules= "length:<4", autoFix= true ) ).toBeTrue();
			});
		});
   
   }

}