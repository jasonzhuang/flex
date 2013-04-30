package {
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	import views.Ball;
	
	/**
	 *	DragConstrainedTest
	 */
	public class DragConstrainedTest extends Sprite {
		private var ball:Ball;
		
		public function DragConstrainedTest()
		{
			init();
		}
		
		private function init():void {
			var container:Sprite = new Sprite();
			container.graphics.clear();
			container.graphics.beginFill(0x000000, 1);
			container.graphics.drawRect(0, 0, 300, 600);
			container.graphics.endFill();
			var rect:Rectangle = new Rectangle(200, 200, 100, 100);
			ball = new Ball();
			container.addChild(ball);
			addChild(container);
			ball.startDrag(true, rect);
		}
	}
}