package utils {
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import events.RetrieveDataCompleteEvent;

    public class ServerLoader extends EventDispatcher{
        private var _loader:URLLoader;

        private var _remoteData:Object;

        public function ServerLoader(urlRequest:URLRequest) {
            _loader = new URLLoader();
            _loader.dataFormat = URLLoaderDataFormat.VARIABLES;
            _loader.addEventListener(Event.COMPLETE, handleComplete);
            _loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, handleStatus);
            _loader.addEventListener(IOErrorEvent.IO_ERROR, handleIOError);
            _loader.load(urlRequest);
        }

        private function handleComplete(event:Event):void {
            var loader:URLLoader = URLLoader(event.target);
            this._remoteData = loader.data;
            this.dispatchEvent(new RetrieveDataCompleteEvent());
        }

        private function handleStatus(event:HTTPStatusEvent):void {
            trace("Load failed: HTTP Status = " + event.status);
        }

        private function handleIOError(event:IOErrorEvent):void {
            trace("Load failed: IO error: " + event.text);
            throw new Error("loader io error");
        }

        public function get remoteData():Object {
            return this._remoteData;
        }
    }
}