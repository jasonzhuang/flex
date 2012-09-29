package {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.Socket;
    import flash.system.Security;
    import flash.text.TextField;
    import flash.utils.ByteArray;

    public class SocketExample extends Sprite {
        private var socket:Socket;
        private var fromServer:TextField;
        private static const serverURL:String = "127.0.0.1";
        private static const port:int = 10000;

        public function SocketExample() {
            initOutput();
            socket = new Socket();
            socket.addEventListener(Event.CONNECT, onConnect);
            socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
            socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
            socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            socket.addEventListener(Event.CLOSE, closeConnect);
            // connect may have error
            try {
                socket.connect(serverURL, port);
            } catch (error:Error) {
                trace(error.message + "\n");
                socket.close();
            }

            Security.loadPolicyFile("http://" + serverURL + "/crossdomain.xml");
            writeToSocket();
        }

        private function writeToSocket():void {
            var message:ByteArray = new ByteArray();
            message.writeMultiByte("Hello java\n", "UTF-8");
            socket.writeBytes(message);
            socket.flush();
        }

        private function initOutput():void {
            fromServer = new TextField();
            fromServer.background = true;
            fromServer.backgroundColor = 0xffffff;
            fromServer.width = 200;
            fromServer.height = 200;
            addChild(fromServer);
        }

        private function closeConnect(event:Event):void {
            socket.close();
        }

        private function onConnect(event:Event):void {
            trace("socket connect succussfully");
        }

        private function onSocketData(event:ProgressEvent):void {
            var n:int = socket.bytesAvailable;
            while(--n >0) {
                var b:int = socket.readUnsignedByte();
                displpayServerInfo(b);
            }
        }

        private function showServerInfo(message:String):void {
            fromServer.text += message + "\n";
        }

        private function displpayServerInfo(message:int):void {
            fromServer.text += String.fromCharCode(message);
        }

        private function securityError(event:SecurityErrorEvent):void {
            trace("security constrains " + event.text);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("Unable to connect: socket error.\n");
        }
    }
}