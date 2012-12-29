package {
	import flash.display.Sprite;
	import flash.system.*;
	
	public class EnviromentInspectTest extends Sprite {
		public function EnviromentInspectTest()
		{
			var log:String = "";
			var os:String = Capabilities.os;
			var version:String = Capabilities.version;
			var audio:Boolean = Capabilities.hasMP3;
			trace("os: " + os + "version: " + version + "audio: " + audio);
		}
	}
}