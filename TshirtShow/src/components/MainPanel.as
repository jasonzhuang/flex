package components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	/**
	 *	MainPanel
	 */
	public class MainPanel extends Sprite {
		[Embed(source="/assets/tip.jpg")]
		private static const TEXT:Class;
		
		private static const BASE:String = "http://st1.yxp.126.net/builder/flash/tshirt/";
		private static const DEFAULT:String = "01.jpg";
		private static const SUFFIX:String = ".jpg"
		
		private var loader:Loader;
		
		private var _tshirt:Bitmap;
		private var _text:Bitmap;
		private var container:Sprite;
		
		public function MainPanel()
		{
			loadTshirt();
			_text = new TEXT();
			_text.x = 100;
			_text.y = 520;
			addChild(_text);
		}
		
		private function loadTshirt():void {
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void {
				trace(event.toString());	
			});
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,  showTshirt);
			loader.load(new URLRequest(BASE + DEFAULT), new LoaderContext(true));
		}
		
		private function showTshirt(event:Event):void {
			if (_tshirt == null) {
				_tshirt = new Bitmap();
				_tshirt.smoothing = true;
			}
			if (_tshirt.parent == null) {
				addChildAt(_tshirt, 0);
			}
			_tshirt.visible = true;
			_tshirt.smoothing = true;
			var data:BitmapData = new BitmapData(loader.content.width, loader.content.height, false, 0);
			var oldData:BitmapData = _tshirt.bitmapData;
			data.draw(Bitmap(loader.content).bitmapData, null, null, null, null, true);
			_tshirt.bitmapData = data;
			_tshirt.smoothing = true;
			if(oldData) {
				oldData.dispose();
			}
		}
		
		public function changeTshirt(color:String):void {
			loader.load(new URLRequest(BASE + color + SUFFIX), new LoaderContext(true));
		}
	}
}