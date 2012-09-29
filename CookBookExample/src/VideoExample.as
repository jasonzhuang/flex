package {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.media.Video;
    import flash.net.NetConnection;
    import flash.net.NetStream;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;

    /**
    * set -use-network=false in compiler
    */

    public class VideoExample extends Sprite {
        private var connection:NetConnection;
        private var videoStream:NetStream;
        private var video:Video;
        private var playbackTime:TextField;
        private var duration:uint;

        public function VideoExample() {
            video = new Video(160, 120);
            playbackTime = new TextField();
            playbackTime.autoSize = TextFieldAutoSize.LEFT;
            playbackTime.y = 120;
            playbackTime.text = "test";
            duration = 0;
            connection = new NetConnection();
            connection.connect(null);
            videoStream = new NetStream(connection);
            videoStream.play("c:/practise/sample.flv");
            var client:Object = {};
            client.onMetaData = onMetaData;
            videoStream.client = client;
            video.attachNetStream(videoStream);
            addChild(video);
            addChild(playbackTime);
            this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        private function onEnterFrame(event:Event):void {
            if (duration > 0 && videoStream.time > 0) {
                playbackTime.text = Math.round(videoStream.time) + "/" + Math.round(duration);
            }
        }

        private function onMetaData(data:Object):void {
            duration = data.duration;
        }
    }
}