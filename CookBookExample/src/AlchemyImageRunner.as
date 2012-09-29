package {
    import cmodule.LomoEffects.CLibInit;
    
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.ByteArray;
    import flash.geom.*

    public class AlchemyImageRunner extends Sprite {
        
        public function AlchemyImageRunner() {
            init();
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
            loader.load(new URLRequest("assets/foto.jpg"));
        }

        private var lomoInitializer:CLibInit;
        private var lomoEncoder:Object;
    
        private function init():void {
            lomoInitializer = new CLibInit();
            lomoEncoder = lomoInitializer.init();
        }

        private function loaded(event:Event):void {
            var bitmapData:BitmapData = Bitmap(event.target.content).bitmapData;
        }
                
        private var img_width:int;
        private var img_height:int;
        private var output:ByteArray;
    
        private var bitmapData:BitmapData;
    
        private function handleClick():void {
            trace("alpha support: " + bitmapData.transparent);
            var pixels:ByteArray = bitmapData.getPixels(bitmapData.rect);//length is 750000
            pixels.position = 0;
            var output:ByteArray = new ByteArray();
            img_width = bitmapData.width;
            img_height = bitmapData.height;
            output = new ByteArray();
            var result:ByteArray = lomoEncoder.encode(pixels, output, img_width, img_height);
            draw(result);
        }
    
        private function draw(output:ByteArray):void {
            var bitmapData:BitmapData = new BitmapData(img_width, img_height, false, 0xFFFFF);
            var rect:Rectangle = new Rectangle(0,0,img_width, img_height);
            bitmapData.setPixels(rect, output);
            var bitmap:Bitmap = new Bitmap(bitmapData);
            this.addChild(bitmap);
        }
    }
}