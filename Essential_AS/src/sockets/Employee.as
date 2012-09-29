package sockets
{
	[Bindable]
	[RemoteClass(alias="sockets.Employee")]
	public class Employee
	{
        public var name:String;
        public var salary:Number;

        public function Employee() {
            
        }
	}
}