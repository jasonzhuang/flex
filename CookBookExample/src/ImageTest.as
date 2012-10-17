package
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    
    public class ImageTest extends Sprite
    {
        public function ImageTest()
        {
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
            loader.load(new URLRequest("assets/foto.jpg"));
        }

        private function loaded(event:Event):void {
            var bitmapData:BitmapData = Bitmap(event.target.content).bitmapData;
            var pixels:ByteArray = bitmapData.getPixels(bitmapData.rect);
            convertToBitmapData(pixels);
        }

        private function convertToBitmapData(byteArray:ByteArray):void {
            var loader:Loader = new Loader();
            loader.loadBytes(byteArray);//Note:Unhandled IOErrorEvent:. text=Error #2124
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
        }

        private function loaderComplete(event:Event):void {
            var loaderInfo:LoaderInfo = LoaderInfo(event.target);
            var bitmapData:BitmapData = new BitmapData(loaderInfo.width, loaderInfo.height, false, 0xFFFFFF);
            bitmapData.draw(loaderInfo.loader);
            var bitmap:Bitmap = new Bitmap(bitmapData);
            this.addChild(bitmap);
        }
    }
}