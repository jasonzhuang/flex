package {
	import flash.display.*;
	import flash.geom.*;
	import flash.text.*;
	
	/**
	 *	BitmapTest
	 */
	public class BitmapTest extends Sprite {
		public function BitmapTest(){
			//case1();
			case2();
		}
		
		private function case1():void {
			var rect:Sprite = new Sprite();
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [0xFF0000, 0x00FF00];
			var alphas:Array = [1, 1];
			var ratios:Array = [127, 255];
			var spreadMethod:String = SpreadMethod.REFLECT ;
			rect.graphics.beginGradientFill(fillType, colors, alphas, ratios, null, spreadMethod);
			rect.graphics.drawRect(0, 0, 200, 150);
			rect.graphics.endFill();
			this.addChild(rect);
			
			/**
			 * 1. bitmapData only draw 100width and 150height of rect which begin from (0,0) of rect
			 * 2. bitmapData.draw(rect , matrix,...), the matrix will effct on rect, NOT on bitmapData itself
			 */
			var bitmapData:BitmapData = new BitmapData(100, 150, false, 0x00000000);
			var matrix:Matrix = new Matrix();
			matrix.scale(0.5, 0.5);
			bitmapData.draw(rect, matrix, null, null, null, true);
			var bitmap:Bitmap = new Bitmap(bitmapData);
			bitmap.x = 300;
			this.addChild(bitmap);
		}
		
		private function case2():void {
			//ALPHA COLOR
			var myBitmapData:BitmapData = new BitmapData(100, 100, true, 0x90000000);
			var tf:TextField = new TextField();
			tf.text = "bitmap text";
			myBitmapData.draw(tf);
			var bm:Bitmap = new Bitmap(myBitmapData);
			this.addChild(bm);

		}
	}
}