package com.netease.component 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Loupe extends Sprite 
	{
		[Embed(source="/assets/loupe.png")]
		private static const LOUPE:Class;
		
		[Embed(source = "/assets/text.png")]
		private static const TEXT:Class;
		
		private var loupe_:Bitmap;
		private var text_:Bitmap;
		
		private var loupeSprite:Sprite;
		
		//the loupe area
		private var image_:Bitmap;
		
		private var mask_:Sprite;
		
		public function Loupe() 
		{			
			mask_ = new Sprite();
			addChild(mask_);
			mask_.graphics.beginFill(0, 1);
			mask_.graphics.drawCircle(75, 75, 75);
			mask_.graphics.endFill();
			image_ = new Bitmap();
			image_.mask = mask_;
			addChild(image_);
			createLoupe();
			text_ = new TEXT();
			text_.x = (loupe_.width - text_.width) / 2.0;
			text_.y = (loupe_.height - text_.height) / 2.0;
			addChild(text_);
		}
		
		private function createLoupe():void {
			loupeSprite = new Sprite();
			loupeSprite.buttonMode = loupeSprite.useHandCursor = true;
			loupe_ = new LOUPE();
			loupeSprite.addEventListener(MouseEvent.MOUSE_OVER, scaleLoupe, false);
			loupeSprite.addEventListener(MouseEvent.MOUSE_OUT, restoreLoupe, false);
			loupeSprite.addChild(loupe_);
			addChild(loupeSprite);
		}
		
		private function scaleLoupe(event:MouseEvent):void {
			loupe_.scaleX = loupe_.scaleY = 1.05;
		}
		
		private function restoreLoupe(event:MouseEvent):void {
			loupe_.scaleX = loupe_.scaleY = 1;
		}
		
		public function setImage(image:Bitmap, dx:Number, dy:Number):void
		{
			text_.visible = false;
			if (image == null) {
				return;
			}
			dx = Math.round((image.bitmapData.width * dx - 75));
			dy = Math.round((image.bitmapData.height * dy - 75));
			var data:BitmapData = new BitmapData(150, 150, false, 0);
			var matrix:Matrix = new Matrix();
			matrix.translate(-dx, -dy);
			data.draw(image, matrix, null, null, null, true);
			image_.bitmapData = data;
			trace(dx, dy);
		}
	}
}