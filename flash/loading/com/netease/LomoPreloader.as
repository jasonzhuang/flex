package com.netease{
	import com.netease.PreloaderDisplay;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import mx.events.FlexEvent;
	import mx.preloaders.DownloadProgressBar;
	
	/**
	 *	LomoPreloader
	 */
	public class LomoPreloader extends DownloadProgressBar {
		private var preloaderDisplay:PreloaderDisplay;
		private var baseText:String = "loading: ";
		
		private var defaultWidth:Number = 440;
		private var defaultHeight:Number = 400;
		
		private var _preloader:Sprite;
		
		public function LomoPreloader(){
			preloaderDisplay = new PreloaderDisplay();
			this.addChild(preloaderDisplay);
		}
		
		public override function set preloader(preloader:Sprite):void  {
			_preloader = preloader;
			
			_preloader.addEventListener(ProgressEvent.PROGRESS, onSWFDownloadProgress);    
			_preloader.addEventListener(Event.COMPLETE, onSWFDownloadComplete);
			_preloader.addEventListener(FlexEvent.INIT_PROGRESS, onFlexInitProgress);
			_preloader.addEventListener(FlexEvent.INIT_COMPLETE , onFlexInitComplete);
			
			centerPreloader();
		}
		
		private function onSWFDownloadProgress( event:ProgressEvent ):void
		{
			var total:Number = event.bytesTotal;
			var loaded:Number = event.bytesLoaded;
			var percent:Number = Math.round((loaded/total) * 100);
			setPreloaderLoadingText(baseText + percent.toString() + "%"); 
			preloaderDisplay.setMainProgress(percent);
		}
		
		private function onSWFDownloadComplete( event:Event ):void
		{
			setPreloaderLoadingText(baseText + 100 + "%");
			preloaderDisplay.setMainProgress(100.0);
		}
		
		private function onFlexInitProgress( event:FlexEvent ):void
		{
			setPreloaderLoadingText("Initializing...");
		}
		
		private function onFlexInitComplete(event:FlexEvent):void {
			this.removeChild(preloaderDisplay);
			removeListerners();
			resetObj();
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function removeListerners():void {
			_preloader.removeEventListener(ProgressEvent.PROGRESS, onSWFDownloadProgress);
			_preloader.removeEventListener(Event.COMPLETE, onSWFDownloadComplete);
			_preloader.removeEventListener(FlexEvent.INIT_PROGRESS, onFlexInitProgress);
			_preloader.removeEventListener(FlexEvent.INIT_COMPLETE , onFlexInitComplete);
		}
		
		private function resetObj():void {
			_preloader = null;
			preloaderDisplay = null;
		}
		
		/**
		 * Makes sure that the preloader is centered in the center of the app.
		 * 
		 */        
		private function centerPreloader():void
		{
			x = (stageWidth / 2) - (defaultWidth / 2);
			y = (stageHeight / 2) - (defaultHeight / 2);
		}
		
		private function setPreloaderLoadingText(value:String):void {
			preloaderDisplay.loading_txt.text = value;
		}

	}
}