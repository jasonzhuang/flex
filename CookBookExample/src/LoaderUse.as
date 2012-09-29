package {
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.net.URLRequest;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.display.Bitmap;
    
    /**
    * Note:
    * After the asset object has been added to the Loader object, and all initialization is
      complete, the Flash runtime dispatches an Event.INIT event. When Event.INIT
      occurs, the asset is considered ready for use.Do not attempt to access
      a loading asset before Event.INIT occurs
      
      * 
    */
    public class LoaderUse extends Sprite {
        private var loader:Loader;
        private var progressOutput:TextField; //the text field in which to display load process

        [Embed(source="assets/Banana.jpg")]
         private var logoClass:Class;

        public function LoaderUse() {
            // Create Loader object and register for events
            createLoader();
            // Create the progress indicator
//            createProgressIndicator();
            // Start the load operation
//            load(new URLRequest("image.jpg"));
        }

        private function createLoader():void {
            // Create the Loader
            loader = new Loader( );
//            loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,
//                    progressListener);
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,
                    completeListener);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
            //Each Loader instance provides a reference to its loading asset’s
            //LoaderInfo object via the instance variable contentLoaderInfo
//            loader.contentLoaderInfo.addEventListener(Event.INIT,
//                    initListener);
        }

        private function ioError(event:IOErrorEvent):void {
            trace("=====io error: " + event.text);
        }

        private function createProgressIndicator ( ):void {
            progressOutput = new TextField( );
            progressOutput.autoSize = TextFieldAutoSize.LEFT;
            progressOutput.border = true;
            progressOutput.background = true;
            progressOutput.selectable = false;
            progressOutput.text = "LOADING...";
        }

        private function load (urlRequest:URLRequest):void {
            loader.load(urlRequest);
            if (!contains(progressOutput)) {
                addChild(progressOutput);
            }
        }

        // Listener invoked whenever data arrives
        private function progressListener (e:ProgressEvent):void {
            // Update progress indicator.
            progressOutput.text = "LOADING: "
                    + Math.floor(e.bytesLoaded / 1024)
                    + "/" + Math.floor(e.bytesTotal / 1024) + " KB";
        }

        private function initListener(e:Event):void {
            addChild(loader.content); // Add loaded asset to display list
            //another way:addChild(loader.getChildAt(0)); //asset is only child in loader
        }

        // Listener invoked when the asset has been fully loaded
        private function completeListener (event:Event):void {
            // Remove progress indicator.
//            removeChild(progressOutput);
            var bitmapData:BitmapData = Bitmap(event.target.content).bitmapData;
        }
    }
}