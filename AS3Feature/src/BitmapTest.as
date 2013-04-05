package {
	import flash.display.*;
	import flash.events.Event;
	import flash.geom.*;
	import flash.net.URLRequest;
	import flash.text.*;
	
	import spark.primitives.Rect;
	
	public class BitmapTest extends Sprite {
		private var _loader:Loader;
		
		public function BitmapTest(){
			//applyScale()
			//applyMatrix();
			//copyPixels();
			//rotateBitmap();
			//applyGraphicsFill();
			//modify();
			applyMatrix2();
		}
	
		private function applyMatrix2():void {
			_loader = new Loader( );
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, beginDraw);
			_loader.load(new URLRequest("assets/1.jpg"));
		}
		
		private function beginDraw(event:Event):void {
			var loader:Loader = (event.target as LoaderInfo).loader;
			var bitmap:Bitmap = loader.content as Bitmap;
		    bitmap.x = 50;
			bitmap.y = 50;
			addChild(bitmap);
			trace(bitmap.transform.matrix);
			
			var oriBitmapData:BitmapData = bitmap.bitmapData;
			var maxSize:Number = 50;
			var w:Number;
			var h:Number;
			if(oriBitmapData.width >  oriBitmapData.height) {
				w = maxSize;
				h = maxSize / oriBitmapData.width * oriBitmapData.height;
			} else {
				h = maxSize;
				w = maxSize / oriBitmapData.height * oriBitmapData.width;
			}
			//the canvas size
			var result:BitmapData = new BitmapData(w, h);
			//calculate the new dimensions of the resized bitmap
			var matrix:Matrix = new Matrix();
			matrix.scale(w / oriBitmapData.width, h/oriBitmapData.height);
			
			//apply matrix will not affect the oriBitmapData
			result.draw(oriBitmapData, matrix, null, null, null, true);
			
			var newBitmap:Bitmap = new Bitmap(result);
			newBitmap.x = 50;
			newBitmap.y = 300;
			addChild(newBitmap);
		}
		
		private function applyScale():void {
			_loader = new Loader( );
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, beginScale);
			_loader.load(new URLRequest("assets/51571.jpg"));//600*435
		}
		
		private function beginScale(event:Event):void {
			var loader:Loader = (event.target as LoaderInfo).loader;
			var bitmap:Bitmap = loader.content as Bitmap;
			var sourceWidth:Number = bitmap.bitmapData.width;
			var sourceHeight:Number = bitmap.bitmapData.height;
			
			//draw slot
			var slotWidth:Number = 300;
			var slotHeight:Number = 100;
			var slot:Shape = new Shape();
			slot.graphics.beginFill(0xff0000, 1);
			slot.graphics.drawRect(0,0,slotWidth,slotHeight);
		    addChild(slot);
			trace("width, height -----", this.width, this.height);//300,100
			//满足slot最长边比例填充
			var ratio:Number = slotWidth/sourceWidth;
			var tx:Number = 0;
			var ty:Number = (sourceHeight*ratio - slotHeight) / 2.0;
			if(ratio < slotHeight / sourceHeight) {
				ratio = slotHeight / sourceHeight;
				tx = (sourceWidth*ratio - slotWidth)/2.0;
				ty = 0;
			}
			
			var matrix:Matrix = new Matrix();
			//the order is important
			matrix.scale(ratio, ratio);
			matrix.translate(-tx, -ty);
			var bitmapData:BitmapData = new BitmapData(slotWidth, slotHeight, true, 0);
			bitmapData.draw(bitmap.bitmapData, matrix, null, null, null, true);
			var result:Bitmap = new Bitmap(bitmapData);
			addChild(result);
			trace("width, height -----", this.width, this.height);
		}
		
		private function applyGraphicsFill():void {
			_loader = new Loader( );
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, beginGraphicsFill);
			_loader.load(new URLRequest("assets/51571.jpg"));
		}
		
		private function beginGraphicsFill(event:Event):void {
			var loader:Loader = (event.target as LoaderInfo).loader;
			var bitmap:Bitmap = loader.content as Bitmap;
			graphics.clear();
			graphics.beginBitmapFill(bitmap.bitmapData, null, false, true);
			graphics.drawRect(100,100,300,300);
			graphics.endFill();
		}
		
		private function rotateBitmap():void {
			_loader = new Loader( );
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, beginRotate);
			_loader.load(new URLRequest("assets/51571.jpg"));
		}
		
		/**
		 * after rotation, the image is blur when the Bitmap smooth set to false
		 */
		private function beginRotate(event:Event):void {
			var loader:Loader = (event.target as LoaderInfo).loader;
			var bitmap:Bitmap = loader.content as Bitmap;
			var ratio:Number = 0.5;
			var matrix:Matrix = new Matrix();
			matrix.scale(ratio, ratio);
			matrix.translate(-bitmap.width*ratio/2, -bitmap.height*ratio/2);
			matrix.rotate(Math.PI*30/180);
			var bitmapData:BitmapData = new BitmapData(bitmap.width*ratio,bitmap.height*ratio, true, 0);
			bitmapData.draw(bitmap.bitmapData, matrix, null, null, null, true);
			var result:Bitmap = new Bitmap(bitmapData, "auto", true);
			addChild(result);
		}
		
		/**
		 * copyPixels( ) operations proved to be 25% to 300% faster than equivalent draw( ) operations
		 * 	sourceRect: A Rectangle object specifying the region of sourceBitmapData that will be copied
					into destinationBitmapData. When alphaBitmapData is supplied, this parameter also
					specifies the width and height of the rectangular region within alphaBitmapData
		 * destPoint: A Point object specifying the top-left corner of the rectangular region within
				destinationBitmapData where the copied pixels will be placed
		 * alphaBitmapData: An optional BitmapData object, separate from sourceBitmapData, whose Alpha
						channel values will become the new Alpha channel values of the pixels written to
						destinationBitmapData
		 * alphaPoint: A Point object specifying the top-left corner of the rectangular region within
					alphaBitmapData
		 * mergeAlpha: the Alpha channels of destinationBitmapData and sourceBitmapData should be combined (true) or the
				Alpha channel of sourceBitmapData should completely replace the existing
				destinationBitmapData Alpha channel (false).
		 */
		private function copyPixels():void {
			var redSquare:BitmapData = new BitmapData(100, 100, true, 0xFFFF0000);
			var blueSquare:BitmapData = new BitmapData(100, 100, true, 0xFF0000FF);
			
			var sourceRect:Rectangle = new Rectangle(50, 50, 50, 50);
			var destPoint:Point = new Point(10, 20);
			
			redSquare.copyPixels(blueSquare, sourceRect, destPoint);
			
			var b:Bitmap = new Bitmap(redSquare);
			addChild(b);
		}
		
		 /**
		 * Note:
		 * 	draw(source, matrix, ...) if source is a DisplayObject, its transformations are not included when it is drawn
		 *	into destinationBitmapData.
		 * Matrix is applied to source pixels.
		 * clipRect defines the area of the source object(after apply matrix) to draw on destinationBitmapData
		 * */
		private function applyMatrix():void {
			var rect:Shape = new Shape( );
			rect.graphics.beginFill(0xFF0000);
			rect.graphics.drawRect(0,0,100,100);
			rect.rotation = 30;
			
			var canvas:BitmapData = new BitmapData(100, 100, false, 0xFFFFFFFF);
			var matrix:Matrix = new Matrix();
			matrix.translate(50, 50);
			canvas.draw(rect, matrix, null, null, null, true);
			
			addChild(new Bitmap(canvas));
		}
		
		/**
		 * 1.Alpha channel value for pixels in nontransparent bitmaps is always 255, even when a different Alpha value is assigned
		 * 2.setPixel() sets only the Red, Green, and Blue channels of a pixel’s color value, leaving the pixel’s
              original Alpha channel unaltered. Using setPixel32() for change alpha channel.
		 */
		private function modify():void {
			var imgData:BitmapData = new BitmapData(100, 100, false, 0xFF0000FF);
			imgData.setPixel32(20, 30, 0xFF000000);
			var bitmap:Bitmap = new Bitmap(imgData);
			addChild(bitmap);
			
			var imgData2:BitmapData = new BitmapData(100, 100, true, 0x660000FF);
			imgData2.setPixel(0, 0, 0xFFFFFF);
			var aphaBitmap:Bitmap = new Bitmap(imgData2);
			addChild(aphaBitmap);
			aphaBitmap.x = aphaBitmap.y = 200;
		}
	}
}