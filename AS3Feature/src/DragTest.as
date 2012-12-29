package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 *	DragTest
	 */
	public class DragTest extends Sprite {
		private var move1:Sprite;
		private var move2:Sprite;
		
		public function DragTest() {
			init();
		}
		
		private function init():void {
			move1 = new Sprite();
			move2 = new Sprite();
			move1.graphics.beginFill(0xff0000,1);
			move1.graphics.drawRect(100,100, 100,100);
			move1.graphics.endFill();
			
			move2.graphics.beginFill(0xffff00,1);
			move2.graphics.drawRect(220,200, 100,100);
			move2.graphics.endFill();
			
			addChild(move1);
			addChild(move2);
			
			addEventListener(MouseEvent.MOUSE_DOWN, function(event:Event):void {
				startDrag(false);
			});
			stage.addEventListener(MouseEvent.MOUSE_UP, function(event:Event):void {
				stopDrag();
			});
		}
		
	}
}