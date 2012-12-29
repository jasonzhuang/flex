package {
	import closure.*;
	/**
	 *	ClosureTest
	 */
	public class ClosureTest {
		private var info:Object = new Object();
		
		public function ClosureTest()
		{
			//case1();
			//case2();
			//case3();
			//case4();
			case5();
		}
		
		/**
		 * create objects using standalone function closures.
		 * All objects created from constructor functions are implicitly dynamic.
		 * From a datatype perspective, the object
		 * referenced by worker is an instance of the Object class, there is no Employee type
		 */
		private function case3():void {
			function Employee (age:int, salary:int) {
				// Define dynamic instance variables
				this.age = age;
				this.salary = salary;
			}
			// ERROR!
			//var worker:Employee = new Employee( );
			var worker = new Employee(25, 12000);
			trace(worker.age);
			with(Math) {
				trace(PI);
			}
		}
		
		private function case2():void {
			var employee:Employee = new Employee();
			employee.startDate = new Date();
			var report:Report = new Report(employee);
			employee["doReport"]();
		}
		
		private function case1():void {
			info["city"] = "hangzhou";
			info["country"] = "china";
			//use the keyword this to access the variables and methods of 
			//the object through which the function was invoked, if omit
			// this from the getAddress() function definition, compile error
			info["getAddress"] = function():String{
				trace(this.city);// keyword this indicates info object instance
				return this.city + ", " + this.country;
				//return city + ", " + country 
			}
			info["getAddress"]();
		}
		
		/**
		 * bound function:
		 A method that is assigned to a variable, passed to a function or method, or returned
		 from a function or method is known as a bound method
		 bound method is permanently linked to the object through
		 which it was originally referenced. In the following code, when eat( ) is
		 invoked via consume, it executes on the Pet object with the name "demo".
		 <b>event-handling</b> system makes extensive use of bound methods.
		 */
		private function case4():void {
			var pet:Pet = new Pet("demo");
			//assign a bound method to consume
			var consume:Function = pet.eat;
			consume(300);
		}
		
		/**
		 * invoke package level function closure
		 */
		private function case5():void {
			var pet:Pet = new Pet("closure");
			pet.invokeFunctionClosure();
		}
	}
}