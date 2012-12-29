package views.autofill {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	/**
	 *	DisplayItem
	 */
	public class DisplayItem extends Sprite {
		// related data .
		protected var vo_:DisplayObjectVO;
		// source image.
		protected var sourceImage_:Loader;
		// view image
		protected var image_:Bitmap;
		
		public function DisplayItem() {
			super();
			mouseEnabled = false;
			mouseChildren = false;
			// create source image.
			sourceImage_ = new Loader();
			// install event listeners.
			sourceImage_.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			sourceImage_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
		}
		
		public function get request():URLRequest {
			var vo:DisplayObjectVO= vo_ as DisplayObjectVO;
			return new URLRequest(vo.url);
		}
		
		protected function onLoadComplete(event:Event):void {
			if (image_ == null) {
				image_ = new Bitmap();
				image_.smoothing = true;
			}
			
			updateContent();
			
			if (image_.parent == null) {
				addChildAt(image_, 0);
			}
			
			image_.visible = true;
			image_.smoothing = true;
		}
		
		private function onLoadError(event:IOErrorEvent):void {
			trace(event.text);
		}
		
		public function load():void {
			if (sourceImage_.content != null) {
				sourceImage_.unload();
			}
			
			var req:URLRequest = request;
			if (req == null) {
				onLoadComplete(null);
				return;
			}
			
			if (image_ != null) {
				image_.visible = false;
			}
			
			sourceImage_.load(req, new LoaderContext(true));
		}
		
		public function set vo(value:DisplayObjectVO):void {
			vo_ = value;
			x = vo_.x;
			y = vo_.y;
			rotation = vo_.rotation
		}
		
		public function get vo():DisplayObjectVO{
			return vo_;
		}
		
		public function updateContent():void {
			var  bmd:BitmapData = Bitmap(sourceImage_.content).bitmapData;
			image_.bitmapData = bmd;
		}

	}
}