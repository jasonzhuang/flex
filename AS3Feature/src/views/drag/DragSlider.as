package views.drag {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	public class DragSlider extends Sprite {
		[Embed(source="assets/roundSlider.png")]
		private var ASSET:Class;
		
		public function DragSlider() {
			var image:Bitmap = new ASSET();
			this.addChild(image);
		}
	}
}