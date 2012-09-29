package {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.net.URLRequest;
    import flash.text.TextField;
    import flash.utils.ByteArray;
    import flash.media.SoundMixer;

    public class SoundExample extends Sprite
    {
        private var _sound:Sound;
        private var _channel:SoundChannel;
        private var _spectrumGraph:BitmapData;

        public function SoundExample()
        {
            _spectrumGraph = new BitmapData(256, 60, true, 0x00000000);
            var bitmap:Bitmap = new Bitmap(_spectrumGraph);
            addChild(bitmap);
            bitmap.x = 10;
            bitmap.y = 10;
            addEventListener(Event.ENTER_FRAME, onEnterFrame);
            _sound = new Sound();
            _sound.load(new URLRequest("http://av.adobe.com/podcast/csbu_dev_podcast_epi_2.mp3"));
            _channel = _sound.play();
        }

        private function onEnterFrame(event:Event):void {
            //showLevel();
            //showSpectrum();
            showProcess();
        }

        private function showProcess():void {
            var barWidth:int = 200;
            var barHeight:int = 5;
            var loaded:int = _sound.bytesLoaded;
            var total:int = _sound.bytesTotal;
            if(total > 0) {
                // Draw a background bar
                graphics.clear( );
                graphics.beginFill(0xFFFFFF);
                graphics.drawRect(10, 10, barWidth, barHeight);
                graphics.endFill( );
                // The percent of the sound that has loaded
                var percent:Number = loaded / total;
                // Draw a bar that represents the percent of
                // the sound that has loaded
                graphics.beginFill(0xCCCCCC);
                graphics.drawRect(10, 10, barWidth * percent, barHeight);
                graphics.endFill( );
            }
        }

        private function showLevel():void {
            var leftLevel:Number = _channel.leftPeak * 100;
            var rightLevel:Number = _channel.rightPeak * 100;
            graphics.clear( );
            graphics.beginFill(0xcccccc);
            graphics.drawRect(10, 10, leftLevel, 10);
            graphics.endFill( );
            graphics.beginFill(0xcccccc);
            graphics.drawRect(10, 25, rightLevel, 10);
            graphics.endFill( );
        }

        public function onID3(event:Event):void {
            // Create a text field and display it
            var id3Display:TextField = new TextField( );
            addChild(id3Display);
            id3Display.x = 10;
            id3Display.y = 20;
            id3Display.width = 200;
            id3Display.height = 200;
            id3Display.background = true;
            id3Display.multiline = true;
            id3Display.wordWrap = true;
            // Add some info about the song to the text field
            id3Display.appendText(_sound.id3.songName + "\n");
            id3Display.appendText(_sound.id3.artist + "\n");
            id3Display.appendText(_sound.id3.album + "\n");
            id3Display.appendText(_sound.id3.year + "\n");
        }

        private function showSpectrum():void {
            // Create the byte array and fill it with data
            var spectrum:ByteArray = new ByteArray( );
            SoundMixer.computeSpectrum(spectrum);
            // Clear the bitmap
            _spectrumGraph.fillRect(_spectrumGraph.rect, 0x00000000);
            // Create the left channel visualization
            for(var i:int=0;i<256;i++) {
                _spectrumGraph.setPixel32(i, 20 + spectrum.readFloat( ) * 20, 0xffffffff);
            }
            // Create the right channel visualization
            for(var i:int=0; i<256; i++) {
                _spectrumGraph.setPixel32(i, 40 + spectrum.readFloat( ) * 20, 0xffffffff);
            }
        }
    }
}
