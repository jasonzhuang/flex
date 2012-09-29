package visitor
{
	public class Cat implements Animal
	{
        public function accetp(v:AnimalVisitor):void {
        	v.visit(this);
        }

        public function eat():void {
        	
        }
	}
}