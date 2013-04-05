package vo
{
	public class Employee {
		public var firstName:String;
		public var lastName:String;
		
		public function Employee(firstName:String = "", lastName:String = "") {
			this.firstName = firstName;
			this.lastName = lastName;
		}
	}
}