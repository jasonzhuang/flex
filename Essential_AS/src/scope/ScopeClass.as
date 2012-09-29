package scope
{
	public class ScopeClass {
	    public function instanceMethod():void {
	        function nestFun():void {
	            trace(a);
	        }
	        //nestFun();
	    }
	}
}

var a:int = 5;

/**
* in the order they were searched"
* 1.nestFun( )’s activation object
* 2.The object through which instanceMethod() was invoked
* 3.SomeClass’s class object
* 4.Object’s class object
* 5.The global object
*/
