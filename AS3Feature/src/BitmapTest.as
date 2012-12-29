package {
	import flash.display.*;
	import flash.events.Event;
	import flash.geom.*;
	import flash.net.URLRequest;
	import flash.text.*;
	
	import spark.primitives.Rect;
	
	/**
	 * bitmap.width is photo width pixel, bitmap.height is photo height pixel
	 */
	public class BitmapTest extends Sprite {
		private var _loader:Loader;
		
		public function BitmapTest(){
			//applyMatrix();
			//applyAlpha();
			//applyClip();
			//copyPixels();
			//rotateBitmap();
			//applyGraphicsFill();
			applyScale();
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
		 * copyPixels(sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point)
		 *
		 * sourceRect of x, y corresponds to the upper-left corner of the source object
		 * destPoint of x,y corresponds to upper-left corner of the rectangular area(BitmapData area) where the new pixels(the bitmap) are placed
		 */
		private function copyPixels():void {
			_loader = new Loader( );
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, beginCopyPixels);
			_loader.load(new URLRequest("assets/50725.jpg"));
		}
		
		private function beginCopyPixels(event:Event):void {
			var loader:Loader = (event.target as LoaderInfo).loader;
			var bitmap:Bitmap = loader.content as Bitmap;
			bitmap.x = 100;//no effect for destPoint
			var bitmapData:BitmapData = new BitmapData(bitmap.width, bitmap.height, false, 0xff0000);
			var image:Bitmap = new Bitmap(bitmapData);
			addChild(image);
			bitmapData.copyPixels(bitmap.bitmapData, new Rectangle(100,0,200,200), new Point(100,50));
		}
		
		/**
		 * clipRect defines the area of the source object(after apply matrix) to draw on bitmapData
		 */
		private function applyClip():void {
			_loader = new Loader( );
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, beginClip);
			_loader.load(new URLRequest("assets/50725.jpg"));
		}
		
		private function beginClip(event:Event):void {
			var loader:Loader = (event.target as LoaderInfo).loader;
			var bitmap:Bitmap = loader.content as Bitmap;
			var bitmapData:BitmapData = new BitmapData(bitmap.width, bitmap.height, false, 0x09000000);
			var matrix:Matrix = new Matrix();
			matrix.scale(0.5, 0.5);
			var clip:Rectangle = new Rectangle(100,100,200,200);
			bitmapData.draw(bitmap, matrix, null, null, clip, true);
			var image:Bitmap = new Bitmap(bitmapData);
			addChild(image);
			//draw the rect with specific color
			bitmapData.fillRect(new Rectangle(25, 25, 50, 50), 0xffff0000);
		}
		
		
		 /**
		 * 1. bitmapData only draw 100 width and 150 height of sourceBitmap which begin from (0,0) of sourceBitmap
		 * 2. bitmapData.draw(rect , matrix,...), the matrix object used to scale, rotate, or translate the coordinates of the source object.
		 * 3. clipRect defines the area of the source object(after apply matrix) to draw on bitmapData
		*/
		private function applyMatrix():void {
			_loader = new Loader( );
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, beginMatrix);
			_loader.load(new URLRequest("assets/50725.jpg"));
		}
		
		private function beginMatrix(event:Event):void {
			var loader:Loader = (event.target as LoaderInfo).loader;
			var bitmap:Bitmap = loader.content as Bitmap;
			bitmap.smoothing = true;
			var ratio:Number = 0.3;
			var matrix:Matrix = new Matrix();
			matrix.scale(ratio, ratio);
			matrix.translate(100,100);//move the sourceBitmap 100,100
		    //bitmap.transform.matrix = matrix;
			//addChild(bitmap);
			//following code has the same effect
			var clip:Rectangle = new Rectangle(200,150,50,50);
			var bitmapData:BitmapData = new BitmapData(bitmap.width*ratio, bitmap.height*ratio, true, 0xffff0000);
			bitmapData.draw(bitmap.bitmapData, matrix, null, null, clip, true);
			var result:Bitmap = new Bitmap(bitmapData);
			trace("result width: " + result.width + ", result height: " + result.height);
			addChild(result);
		}
		
		private function applyAlpha():void {
			var myBitmapData:BitmapData = new BitmapData(100, 100, true, 0x90000000);
			var tf:TextField = new TextField();
			tf.text = "bitmap text";
			myBitmapData.draw(tf);
			var bm:Bitmap = new Bitmap(myBitmapData);
			this.addChild(bm);

		}
	}
}