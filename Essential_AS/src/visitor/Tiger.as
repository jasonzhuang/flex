package visitor
{
	public class Tiger implements Animal
	{
		public function accept(v:AnimalVisitor):void {
			v.visit(this);
		}

        public function eat():void {
        	
        }
	}
}