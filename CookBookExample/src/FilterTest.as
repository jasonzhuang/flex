package
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.utils.*;

	public class FilterTest extends Sprite{
		private var myBitmapData:BitmapData;
		private var myDisplayObject:Bitmap;
        public function FilterTest() {
            init();
            invokeDraw();
            getArea();
        }

        private function applyFilter():void {
//            var filters:Array = [gradientBevelFilter()];
//          myDisplayObject.filters = filters;
        }

        private function getArea():void {
            myDisplayObject.x = 100;
            var boundsRect:Rectangle = myDisplayObject.getBounds(this);
            trace(boundsRect);
            var rect:Rectangle = myDisplayObject.getRect(this);
            trace(rect);
        }

        private function init():void {
            myBitmapData = new BitmapData(100, 100, false,0xFFFF3300);
            myDisplayObject = new Bitmap(myBitmapData);
        }

        private function baseUse():void {
            myBitmapData.noise(500, 0, 255, BitmapDataChannel.BLUE, false);
            addChild(myDisplayObject);
            myDisplayObject.x = 10;
            var timer:Timer = new Timer(2000);
            timer.addEventListener(TimerEvent.TIMER, scrollBitmap);
            timer.start();

            var rect:Rectangle = new Rectangle(0, 0, 20, 20);
            var pt:Point = new Point(0, 20);//relative to destination Bitmap
            var bmd:BitmapData = new BitmapData(80, 40, false, 0x0000CC44);
            bmd.copyPixels(myBitmapData, rect, pt);
            var bm:Bitmap = new Bitmap(bmd);
            this.addChild(bm);
            bm.x = 200;
        }

        private function invokeDraw():void {
            var tf:TextField = new TextField();
            tf.text = "bitmap text";
            
            var myBitmapData:BitmapData = new BitmapData(80, 20, true, 0xFF00000);
            myBitmapData.draw(tf);
            var bmp:Bitmap = new Bitmap(myBitmapData);
            this.addChild(bmp);
        }

        private function scrollBitmap(event:Event):void {
        	myBitmapData.scroll(5,5);
        }

        private function bevelFilter():BevelFilter {
            var bevel:BevelFilter = new BevelFilter();
			bevel.distance = 5;
			bevel.angle = 45;
//			bevel.highlightColor = 0xFFFF00;
			bevel.highlightAlpha = 0.8;
//			bevel.shadowColor = 0x666666;
			bevel.shadowAlpha = 0.8;
			bevel.blurX = 5;
			bevel.blurY = 5;
			bevel.strength = 5;
			bevel.quality = BitmapFilterQuality.HIGH;
			bevel.type = BitmapFilterType.INNER;
			bevel.knockout = false;
			return bevel;
        }

        private function blurFilter():BlurFilter {
			var blur:BlurFilter = new BlurFilter();
			blur.blurX = 10;
			blur.blurY = 10;
			blur.quality = BitmapFilterQuality.MEDIUM;
			return blur;
        }

        private function glowFilter():GlowFilter {
            var glow:GlowFilter = new GlowFilter();
			glow.color = 0x009922;
			glow.alpha = 1;
			glow.blurX = 25;
			glow.blurY = 25;
			glow.quality = BitmapFilterQuality.MEDIUM;
			return glow;
        }

        private function gradientBevelFilter():GradientBevelFilter {
        	var gradientBevel:GradientBevelFilter = new GradientBevelFilter();

			gradientBevel.distance = 8;
			gradientBevel.angle = 30;
			gradientBevel.colors = [0xFFFFCC, 0xFEFE78, 0x8F8E01];
			gradientBevel.alphas = [1, 0, 1];
			gradientBevel.ratios = [0, 128, 255];
			gradientBevel.blurX = 8;
			gradientBevel.blurY = 8;
			gradientBevel.quality = BitmapFilterQuality.HIGH;
			return gradientBevel;
        }
	}
}