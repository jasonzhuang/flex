package {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import views.Ball;
	
	/**
	 *	DragConstrainedTest
	 */
	public class CollisionTest extends Sprite {
		public function CollisionTest()
		{
			init();
		}
		
		private function init():void {
			var fixRect:Shape = new Shape();
			fixRect.graphics.clear();
			fixRect.graphics.beginFill(0x000000, 0.9);
			fixRect.graphics.drawRect(200, 100, 100, 100);
			fixRect.graphics.endFill();
			addChild(fixRect);
			
			var rect:Shape = new Shape();
			rect.graphics.clear();
			rect.graphics.beginFill(0xFF0000, 0.6);
			//rect.graphics.drawRect(150, 150, 100, 100);
			rect.graphics.drawRect(200 - 50, 100 -50, 100 + 50*2, 100 + 50*2);
			rect.graphics.endFill();
			addChild(rect);
			
			var inter:Rectangle = rect.getBounds(this).intersection(fixRect.getBounds(this));
			trace(inter);
			trace(inter.right, inter.bottom);
			
			var adjust:Shape = new Shape();
			adjust.graphics.clear();
			adjust.graphics.beginFill(0x0000FF, 0.8);
			adjust.graphics.drawRect(150, 150, 100, 100);
			adjust.graphics.endFill();
			adjust.x -= inter.width;
			adjust.y += inter.height;
			//this.addChild(adjust);
		}
	}
}