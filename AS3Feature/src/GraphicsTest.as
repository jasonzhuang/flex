package
{
    import flash.display.*;
    import flash.events.Event;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.net.URLRequest;
    
    public class GraphicsTest extends Sprite
    {
		/**
		 * When drawings are made within the graphics objects,
		 * they appear in the display object below any children that may have been added to them
		 */
		private var _loader:Loader;
		
        public function GraphicsTest() {
			//drawOrder();
			//drawLine();
			drawRect();
			//drawCircle();			
			//drawPath();
			//drawTriangle();
			//fillBitmap();
        }
		
		/**
		 * notice the bound value
		 */
		private function drawCircle():void {
			var container:Sprite = new Sprite();
			container.x = 100;
			container.y = 100;
			addChild(container);
			var circle:Shape = new Shape();
			circle.graphics.beginFill(0x0000FF);
			circle.graphics.drawCircle(40, 40, 40);
			circle.x = 10;
			container.addChild(circle);
			trace(circle.getBounds(container));//[10,0,80,80]
			trace(circle.getBounds(this));//[110,100,80,80]
		}
		
		private function fillBitmap():void {
			_loader = new Loader( );
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoad);
			_loader.load(new URLRequest("assets/50725.jpg"));
		}
		
		private function onImageLoad(event:Event):void {
			var loader:Loader = (event.target as LoaderInfo).loader;
			var bitmap:Bitmap = loader.content as Bitmap;
			var bitmapData:BitmapData = new BitmapData(bitmap.width, bitmap.height, false, 0xffffff);
			var matrix:Matrix = new Matrix();
			matrix.scale(0.5, 0.5);
			bitmapData.draw(bitmap, matrix, null, null, null, true);
			var sampleSprite:Sprite = new Sprite();
			sampleSprite.graphics.lineStyle();
			sampleSprite.graphics.beginBitmapFill(bitmapData, null, false, true);
			sampleSprite.graphics.drawRect(0,0,300,300);
			sampleSprite.graphics.endFill();
			addChild(sampleSprite);
		}
		
		private function drawOrder():void {
			var rect:Shape = new Shape();
			rect.graphics.lineStyle(1, 0x000000);
			rect.graphics.beginFill(0xFF0000);
			rect.graphics.drawRect(50, 50, 100, 100);
			addChild(rect);
			
			//the drawing below any children
			graphics.lineStyle(1, 0x000000);
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, 100, 100);
		}
		
		/**
		 *draw line
		 */
		private function drawLine():void {
			var shape:Shape = new Shape();    
			
			shape.graphics.lineStyle(10, 0xFFD700, 1);
			
			shape.graphics.moveTo(100, 100);
			
			shape.graphics.lineTo(120, 50);
			shape.graphics.lineTo(200, 50);
			shape.graphics.lineTo(220, 100);
			shape.graphics.lineTo(100, 100);
			this.addChild(shape);
		}
		
		/**
		 * x: A number indicating the horizontal position relative to the registration point of the <b>parent</b> display object
		 */
		private function drawRect():void {
			var rect:Shape = new Shape();
			rect.graphics.clear();
			rect.graphics.beginFill(0xFFFF00);
			rect.graphics.drawRect(100, 100, 200, 200);
			rect.graphics.endFill();
			rect.x = 50;
			addChild(rect);
			trace(rect.getBounds(this));//[150,100,200,200]
		}
		
		/**
		 * draw path
		 * For non-curveTo and non-wide commands, commands.length = data.length/2.
		 * When using curveTo and wide commands, commands.length = data.length/4.
		 */
		private function drawPath():void {
			var commands:Vector.<int> = new Vector.<int>(5, true);
			commands[0] = GraphicsPathCommand.MOVE_TO;
			commands[1] = GraphicsPathCommand.LINE_TO;
			commands[2] = GraphicsPathCommand.LINE_TO;
			commands[3] = GraphicsPathCommand.LINE_TO;
			commands[4] = GraphicsPathCommand.LINE_TO;
			
			var data:Vector.<Number> = new Vector.<Number>(10, true);
			data[0] = 10; // x
			data[1] = 10; // y
			data[2] = 100;
			data[3] = 10;
			data[4] = 100;
			data[5] = 100;
			data[6] = 10;
			data[7] = 100;
			data[8] = 10;
			data[9] = 10;
			
			graphics.beginFill(0x800000);
			graphics.drawPath(commands, data);
		}
		
		/**
		 * Trinagle indices
		 * 0######1
		 * #          #
		 * #          #
		 * #          #
		 * 2######3
		 */
		private function drawTriangle():void {
			graphics.beginFill(0xFF8000);
			graphics.drawTriangles(
				Vector.<Number>([10,10, 100,10, 10,100, 100,100]),
				Vector.<int>([0,1,2, 1,3,2]));
		}
    }
}