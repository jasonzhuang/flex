package {
    import dataLoad.ServerLoader;

    import events.RetrieveDataCompleteEvent;

    import flash.display.Sprite;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import flash.text.TextField;

    /**
    * URLLoader :data can not be read until the download is complete
    * URLStream: read data as it arrives, not need to wait complete
    */

    public class URLLoaderExample extends Sprite {
        private static const URL:String = "http://localhost:7001/flex_java_Integration/Employees.jsp";
        private var loader:ServerLoader;
        private var display:TextField;

        public function URLLoaderExample() {
            initDisplay();
            var urlRequest:URLRequest = buildURL();
            loader = new ServerLoader(urlRequest);
            loader.addEventListener(RetrieveDataCompleteEvent.COMPLETE, handleResult);
        }

        private function initDisplay():void {
            display = new TextField();
            display.background = true;
            display.backgroundColor = 0xffffff;
            display.width = 200;
            display.height = 300;
            addChild(display);
        }

        private function handleResult(event:RetrieveDataCompleteEvent):void {
            if(!loader.remoteData) {
                return;
            }

            displayResult();
        }

        private function displayResult():void {
            display.text = String(loader.remoteData);
        }

        private function buildURL():URLRequest {
            var urlRequest:URLRequest = new URLRequest(URL);
            var variables:URLVariables = new URLVariables();
            variables.id = 10;
            urlRequest.data = variables;
            return urlRequest;
        }
    }
}