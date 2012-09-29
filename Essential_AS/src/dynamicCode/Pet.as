package dynamicCode
{
	public class Pet
	{
        private var name:String;

        public function Pet(name:String) {
            this.name = name;
        }

        public function eat(amount:int):void {
            trace("eat " + amount);
            trace(this.toString());
        }

        public function toString():String {
            return this.name;
        }

        public function invokeFunctionClosure():void {
            sampleClosure();
        }

	}
}