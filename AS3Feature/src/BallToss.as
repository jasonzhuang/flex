package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 *	BallToss
	 */
	public class BallToss extends Sprite {
		private var ball:TossableBall;
		private var lastMouse:Point = new Point();
		private var mouseMoved:Point = new Point();
		
		public function BallToss() {
			var bounds:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			ball = new TossableBall(50, bounds);
			ball.x = bounds.x + bounds.width/2;
			ball.y = bounds.y + bounds.height/2;
			addChild(ball);
			
			ball.addEventListener(MouseEvent.MOUSE_DOWN, grabBall);
			ball.addEventListener(MouseEvent.MOUSE_UP, releaseBall);
		}
		
		private function grabBall(evt:MouseEvent):void {
			ball.toss(new Point(0,0));
			ball.startDrag();
			lastMouse = new Point(mouseX, mouseY);
			
			addEventListener(Event.ENTER_FRAME, moveBall);
			moveBall(new Event(Event.ENTER_FRAME));
		}
		
		private function releaseBall(evt:MouseEvent):void {
			ball.stopDrag();
			ball.toss(mouseMoved);
			
			removeEventListener(Event.ENTER_FRAME, moveBall);
		}
		
		private function moveBall(evt:Event):void {
			var currMouse:Point = new Point(mouseX, mouseY);
			mouseMoved = currMouse.subtract(lastMouse);
			lastMouse = currMouse;
		}
	}
}
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;

class TossableBall extends Sprite {
	
	private var bounds:Rectangle;
	private var vector:Point = new Point();
	private var friction:Number = .95;
	
	public function TossableBall(size:Number, throwBounds:Rectangle) {
		bounds = throwBounds;
		graphics.lineStyle(1);
		graphics.beginFill(0xFF8000);
		graphics.drawCircle(0, 0, size/2);
		
		addEventListener(Event.ENTER_FRAME, soar);
	}
	
	public function toss(tossVector:Point):void {
		vector = tossVector;
	}
	
	private function soar(evt:Event):void {
		x += vector.x;
		y += vector.y;
		var shapeBounds:Rectangle = getBounds(parent);
		if (shapeBounds.left < bounds.left) {
			vector.x = Math.abs(vector.x);
		}else if (shapeBounds.right > bounds.right) {
			vector.x = -Math.abs(vector.x);
		}
		if (shapeBounds.top < bounds.top) {
			vector.y = Math.abs(vector.y);
		}else if (shapeBounds.bottom > bounds.bottom) {
			vector.y = -Math.abs(vector.y);
		}
		vector.x *= friction;
		vector.y *= friction;
	}
}