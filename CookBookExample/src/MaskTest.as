package
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
	
    public class MaskTest extends Sprite
    {
		private var maskSprite:Sprite;
		
		//show mask area
        public function MaskTest() {
			var loader:Loader = new Loader( );
			loader.load(new URLRequest("assets/foto.jpg"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
        }
		
		private function completeHandler(event:Event):void {
			buildMask();
			var w:Number = event.target.width;
			var h:Number = event.target.height;
			var bitmapData:BitmapData = new BitmapData(w, h, false, 0xffffffff);
			bitmapData.draw(event.target.content);
			var bitmap:Bitmap = new Bitmap(bitmapData);
			bitmap.mask = maskSprite;
			addChild(bitmap);
		}
		
		private function errorHandler(event:Event):void {
			
		}
		
		private function buildMask():void {
			maskSprite = new Sprite( );
			maskSprite.graphics.lineStyle( );
			maskSprite.graphics.beginFill(0xFFFFFF);
			maskSprite.graphics.drawCircle(0, 0, 80);
			maskSprite.graphics.endFill( );
			addChild(maskSprite);
			maskSprite.startDrag(true);
		}
    }
}