package
{
	import com.netease.component.LoupePanel;
	import com.netease.component.Loupe;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	public class LoupeImage extends Sprite 
	{
		public static const BASE:String = "http://st1.yxp.126.net/builder/flash/albumPage";
		
		private var imageSelector_:int;
		
		public function LoupeImage():void 
		{
			init();
		}
		
		private function init(e:Event = null):void 
		{
			initStageMode();
			if ('image' in loaderInfo.parameters) {
				imageSelector_ = parseInt(loaderInfo.parameters['image']);
			} else {
				imageSelector_ = 1;
			}
			
			createChildren();
		}
		
		private function initStageMode():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		private function createChildren():void
		{
			loadBackground();
			//rect.x and rect.y is the LoupePanel coordiantion
			var rect:Rectangle = new Rectangle(64 - 75, 36 - 75, 325, 325);
			if (imageSelector_ == 2) {
				rect = new Rectangle(26 - 75, 10 - 75, 372, 372);
			}
			createLoupePanel(rect);
		}
		
		private function loadBackground():void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(event:Event):void {
				trace(Event);
			});
			loader.load(new URLRequest(BASE + imageSelector_ + ".jpg"));
			addChild(loader);
		}
		
		private function createLoupePanel(rect:Rectangle):void
		{
			var panel:LoupePanel = new LoupePanel(rect, imageSelector_);
			panel.x = rect.x + 75;
			panel.y = rect.y + 75;
			addChild(panel);
		}
	}	
}