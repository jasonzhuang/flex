package com.netease.component 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.external.ExternalInterface;
	
	public class LoupePanel extends Sprite 
	{
		private static const  RIGHT_EDGE:Number = 840;
		
		private var bounds_:Rectangle;
		
		private var imageSelector_:int;
		
		private var loader1_:Loader;
		private var loader2_:Loader;
		
		private var loupe1:Loupe;
		private var loupe2:Loupe;
		
		//use for loupe1 animation
		private var timer1:Timer;
		//use for loupe2 animation
		private var timer2:Timer;
		private var loupe1TargetX:Number;
		private var loupe2TargetX:Number;
		private var _easingSpeed:Number = 0.2;
		
		public function LoupePanel(bounds:Rectangle, imageSelector:int):void 
		{
			expose2JS();
			bounds_ = bounds;
			imageSelector_ = imageSelector;
			createLoupes();
			addEventListener(Event.ADDED_TO_STAGE, init);
			loadImages();
		}
		
		private function expose2JS():void {
			ExternalInterface.addCallback("doAnimation", doAnimation);
		}
		
		private function createLoupes():void {
			loupe1 = new Loupe();
			addChild(loupe1);
			loupe2 = new Loupe();
			addChild(loupe2);
			hideLoupes();
			//doAnimation();
		}
		
		private function hideLoupes():void {
			loupe1.visible = loupe1.mouseChildren =  loupe2.visible = loupe2.mouseChildren = false;
		}
		
		private function showLoupes():void {
			loupe1.visible = loupe1.mouseChildren =  loupe2.visible = loupe2.mouseChildren = true;
		}
		
		private function doAnimation():void {
			showLoupes();
			loupe1Ease();
			loupe2Ease();
		}
		
		private function loupe1Ease():void {
			loupe1TargetX = 0;
			loupe1.x = imageSelector_ == 1 ? 389: 398;
			timer1 = new Timer(30);
			timer1.addEventListener(TimerEvent.TIMER, onTimer1);
			//expose function
			timer1.start();
		}
		
		private function loupe2Ease():void {
			loupe2TargetX = imageSelector_ == 1 ? 448 :440;
			//right edge
			loupe2.x = RIGHT_EDGE;
			timer2 = new Timer(30);
			timer2.addEventListener(TimerEvent.TIMER, onTimer2);
			//expose function
			timer2.start();
		}

		private function onTimer1(event:TimerEvent):void {
			var dx:Number = loupe1TargetX - loupe1.x;
			var dist:Number = Math.sqrt(Math.abs(dx) * Math.abs(dx));
			if(dist < 1)
			{
				loupe1.x = loupe1TargetX;
				timer1.stop( );
			} else {
				var vx:Number = dx * _easingSpeed;
				loupe1.x += vx;
			}
		}
		
		private function onTimer2(event:TimerEvent):void {
			var dx:Number = loupe2TargetX - loupe2.x;
			var dist:Number = Math.sqrt(Math.abs(dx) * Math.abs(dx));
			if(dist < 1)
			{
				loupe2.x = loupe2TargetX;
				timer2.stop( );
			} else {
				var vx:Number = dx * _easingSpeed;
				loupe2.x += vx;
			}
		}
		
		private function loadImages():void {
			loader1_ = new Loader();
			loader2_ = new Loader();
			loader1_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(event:Event):void {
				trace("1:" + event.toString);
			});
			loader2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(event:Event):void {
				trace("2:" + event.toString);
			});
			loader1_.load(new URLRequest(LoupeImage.BASE + imageSelector_ + "-1.jpg"));
			loader2_.load(new URLRequest(LoupeImage.BASE + imageSelector_ + "-2.jpg"));
		}
		
		private function init(event:Event):void
		{
			//drag both loupe
			addEventListener(MouseEvent.MOUSE_DOWN, function(event:Event):void {
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				startDrag(false, bounds_);
			});
			stage.addEventListener(MouseEvent.MOUSE_UP, function(event:Event):void {
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				stopDrag();
			});
		}
		
		private function onMouseMove(event:Event):void
		{
			var w:Number = imageSelector_ == 1 ? 325 : 372;
			var offset:Number = imageSelector_ == 1 ? 0 : 0;
			loupe1.setImage(loader1_.content as Bitmap, (x - bounds_.x - offset) / w , (y - bounds_.y) / w);
			loupe2.setImage(loader2_.content as Bitmap, (x - bounds_.x - offset) / w , (y - bounds_.y) / w);
		}
	}

}