package
{
    import flash.display.*;

    public class GraphicsTest extends Sprite
    {
        public function GraphicsTest() {
			case1();
        }
		
		private function case1():void {
			var shape:Shape = new Shape();    
			
			shape.graphics.lineStyle(10, 0xFFD700, 1);
			
			shape.graphics.moveTo(100, 100);
			
			shape.graphics.lineTo(120, 50);
			shape.graphics.lineTo(200, 50);
			shape.graphics.lineTo(220, 100);
			shape.graphics.lineTo(100, 100);
			this.addChild(shape);
		}
    }
}