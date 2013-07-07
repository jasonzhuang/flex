package {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import views.Ball;
	
	/**
	 * it is a good idea to draw at the origin (coordinate 0,0) and apply transformations—scale, translate, rotate, and so forth
     * The reason is that transforms such as scale and rotate operate from the origin upper-left hand corner(0,0)
	 */
	public class CoordsTransformTest extends Sprite {
		public function CoordsTransformTest()
		{
			//rotationCenter();
			//mouseLocation();
			//pointTransform();
			//translateObj();
			coordinateRotate();
		}
		
		/**
		 * when set x, y, rotation, matrix is automatically created 
		 */
		private function translateObj():void {
			var container:Sprite = new Sprite();
			container.x = 100;
			addChild(container);
			trace("container matrix: ", container.transform.matrix);//(a=1, b=0, c=0, d=1, tx=100, ty=0) =====tx=100=====
			var rect:Sprite = new Sprite();
			rect.graphics.beginFill(0xff0000,1);
			rect.graphics.drawRect(0,0,100,100);
			rect.graphics.endFill();
			container.addChild(rect);
			trace("rect matrix: ", rect.transform.matrix);//(a=1, b=0, c=0, d=1, tx=0, ty=0)
			var matrix:Matrix = new Matrix();
			matrix.translate(100,100);
			rect.transform.matrix = matrix;
			trace("rect matrix", rect.transform.matrix);//(a=1, b=0, c=0, d=1, tx=100, ty=100)
			var matrix1:Matrix = new Matrix(1,0,0,1,100,0);
			var matrix2:Matrix = new Matrix(1,0,0,1,100,0);
			matrix1.concat(matrix2);
			trace("multi matrix:  " + matrix1);//(a=1, b=0, c=0, d=1, tx=200, ty=0)
		}
		
		/**
		 * 
		 * displayObj.localToGlobal(point), the x and y value of point parameters specify a point in the coordinate space of the displayObj
		 * displayObj.globalToLocal(point), the x and y value of point parameters specify a point in the coordinate space of the Stage
		 */
		private function pointTransform():void {
			var rect:Sprite = new Sprite();
			rect.graphics.beginFill(0xff0000,1);
			rect.graphics.drawRect(0,0,100,100);
			rect.graphics.endFill();
			rect.x = 50;
			rect.y = 50;
			addChild(rect);
			var p1:Point = rect.globalToLocal(new Point(0,0));
			trace(p1);//-50,-50
			var p2:Point = rect.localToGlobal(new Point(0,0));
			trace(p2);//50,50
			var child:Sprite = new Sprite();
			child.graphics.beginFill(0xffff00,1);
			child.graphics.drawRect(0,0,50,50);
			child.graphics.endFill();
			child.x = 10;
			child.y = 10;
			rect.addChild(child);
			var p3:Point = child.localToGlobal(rect.globalToLocal(new Point(0,0)));
			trace(p3);//10,10
		}
		
		private function mouseLocation():void {
			var rect:Sprite = new Sprite();
			rect.graphics.beginFill(0xff0000,1);
			rect.graphics.drawRect(0,0,100,100);
			rect.graphics.endFill();
			rect.x = 5;
			rect.y= 10;
			rect.addEventListener(MouseEvent.CLICK, handleMouseClick);
			addChild(rect);
		}
		
		/**
		 * The mouseX and mouseY properties can be inspected to determine the location of the mouse cursor
		 * relative to the top-left corner of the DisplayObject.
		 * 
		 * The localX and localY are relative to interactive display object that dispatched the event.
		 * 
		 * mouseX = localX, mouseY = localY;
		 */
		private function handleMouseClick(event:MouseEvent):void {
			trace( "local x: " + event.localX );
			trace( "local y: " + event.localY );
			
			trace("mouse x: " + event.target.mouseX);
			trace("mouse y: " + event.target.mouseY);
			// Create the point that localToGlobal should convert
			var localPoint:Point = new Point(event.localX, event.localY);
			// Convert from the local coordinates of the display object that
			// dispatched the event to the global stage coordinates
			var globalPoint:Point = event.target.localToGlobal(localPoint);
			trace( "global x: " + globalPoint.x );
			trace( "global y: " + globalPoint.y );
		}
		
		private function rotationCenter():void {
			var rect:Shape = new Shape();
			rect.graphics.beginFill(0xff0000, 1);
			rect.graphics.drawRect(0,0,100,100);
			rect.graphics.endFill();
			rect.x = 100;
			rect.y = 100;
			addChild(rect);
			trace(rect.getBounds(this));
			var angleInRadians:Number = Math.PI * 2 * (45 / 360);
			var matrix:Matrix = new Matrix();
			//This forces the rotation operation to occur at the center of the object rather than the upper left-hand corner
			matrix.translate(-50, -50);
			// This will rotate the rect object on the current x,y point, which is the center because of the translate() call above
			matrix.rotate(angleInRadians);
			//we must move the rect back to its original position
			matrix.translate(rect.x + 50, rect.y + 50);
			rect.transform.matrix = matrix;
			trace(rect.getBounds(this));
		}
		
		private function coordinateRotate():void {
			var ball:Ball = new Ball(30);
			var x:Number = 30;
			var y:Number = 200;
			ball.x = x;
			ball.y = y;
			var angle:Number = 30;
			var cos:Number = Math.cos(angle*Math.PI/180);
			var sin:Number = Math.sin(angle*Math.PI/180);
			
			var x1:Number = cos*x - sin*y;
			var y1:Number = cos*y + sin*x;
			trace("x1: ", x1, ", y1: ", y1);
			
			var matrix:Matrix = new Matrix();
			matrix.rotate(angle);
			var p1:Point = matrix.transformPoint(new Point(x, y));
			trace("p1: ", p1);
		}
	}
}