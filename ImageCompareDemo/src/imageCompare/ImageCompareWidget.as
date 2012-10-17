package imageCompare {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import imageCompare.OrderLoader;
	
	/**
	 *	ImageCompare
	 */
	public class ImageCompareWidget extends Sprite {
		private var _before:Bitmap;
		private var _after:Bitmap;
		private var _mask:Sprite;
		private var _divider:Bitmap;
		private var dividerWrapper:Sprite;
		
		[Embed(source="assets/divider.png")]
		private var _asset:Class;
		
		private static const DIVIDER_URL:String = "";
		
		private static const TOTAL:int = 2;
		
		private var orderList:Array = [];
		private var urlPool:Array = [];
		
		public function ImageCompareWidget(beforeUrl:String, afterUrl:String, options:Object = null)
		{
			urlPool.push(beforeUrl);
			urlPool.push(afterUrl);
			configDivider();
			configLoader();
		}
		
		private function configDivider():void {
			_divider = new _asset();
			dividerWrapper = new Sprite();
			dividerWrapper.addChild(_divider);
		}
		
		private function configLoader():void {
			for (var i:int=0; i<TOTAL; i++) {
				loaderImages(i);
			}
		}
		
		private function loaderImages(index:int):void {
			var loader:OrderLoader = new OrderLoader(index);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.load(new URLRequest(urlPool[index]));
		}
		
		private function completeHandler(event:Event):void {
			var loader:OrderLoader = (event.target as LoaderInfo).loader as OrderLoader;
			if(loader.index == 0) {
				_before = new Bitmap(Bitmap(loader.content).bitmapData);
			} else {
				_after = new Bitmap(Bitmap(loader.content).bitmapData);
			}
			
			orderList[loader.index] = loader.index;
			populate();
		}
		
		private function errorHandler(event:IOErrorEvent):void {
			trace("loader image error: " + event.text);
		}
		
		private function populate():void {
			if(isAllLoaded()) {
				constructUI();
			}
		}
		
		private function isAllLoaded():Boolean {
			if(orderList.length != TOTAL) {
				return false;
			}
			
			for (var index:int=0; index<orderList.length; index++) {
				if(orderList[index] == null) {
					return false;
				}
			}
			
			return true;
		}
		
		private function constructUI():void {
			_mask = new Sprite();
			_mask.graphics.beginFill(0x000000);
			_mask.graphics.drawRect(0,0,600,282);
			_mask.graphics.endFill();
			
			this.addChild(_mask);
			
			_after.mask = _mask;
			
			this.addChild(_before);
			this.addChild(_after);
			this.addChild(dividerWrapper);
			
			dividerWrapper.x = 200;
			_mask.x = dividerWrapper.x;
			
			dividerWrapper.buttonMode = true;
			dividerWrapper.addEventListener(MouseEvent.MOUSE_DOWN, slidebarEvents, false, 0, true);  
			
			stage.addEventListener(MouseEvent.MOUSE_UP, stopEvents, false, 0, true); 
		}
		
		private function slidebarEvents(e:MouseEvent):void {  
			stage.addEventListener(MouseEvent.MOUSE_MOVE, move, false, 0, true);
		}
		
		private function stopEvents(e:MouseEvent):void {  
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, move);
		}
		
		private function move(event:MouseEvent):void {
			dividerWrapper.x = mouseX;
			if (dividerWrapper.x > stage.stageWidth) {
				dividerWrapper.x = stage.stageWidth;
			} else if(_divider.x < 0) {
				dividerWrapper.x = 0;
			}
			
			_mask.x = dividerWrapper.x;
		}
		
	}
}