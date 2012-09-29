package vo {
    public class Person {
        private var _name:String;
        private var _age:int;

        public function Person(name:String, age:int) {
            this._name = name;
            this._age = age;
        }

        public function toString():String {
            return _name + "is " + _age + " years old";
        }
    }
}