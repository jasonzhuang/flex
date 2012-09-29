package visitor
{
	public class AnimalVisitor
	{
		public function visit(animal:Animal):void {
			animal.eat();
		}
		
		//compile error
//		public function visit(tiger:Tiger):void {
//			tiger.eat();
//		}
	}
}