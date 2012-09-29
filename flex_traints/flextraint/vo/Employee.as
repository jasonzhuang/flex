package vo {
    [Bindable]
    public class Employee {
        public var firstName:String;
        public var lastName:String;

        private var _age:Number;

        public static function eat():void {
            trace("eat....");
        }

        [Bindable("ageChanged")]
        public function get age():Number {
            return _age;
        }

        public function set age( value:Number ):void {
            _age = value;
            dispatchEvent( new Event( "ageChanged" ) );
        }

        public static var company:String;

        public function Employee(firstName:String = null, lastName:String = null) {
            this.firstName = firstName;
            this.lastName = lastName;
        }

        public function raiseSalary(rate:Number):void {
            this.salary *= rate;
        }

        private var salary:Number;

        [ArrayElementType("vo.Employee")]
        [Transient]
        public var subordinate:Array;
    }
}