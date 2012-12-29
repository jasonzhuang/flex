package views.autofill {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;

	/**
	 *	PhotoItem
	 */
	public class PhotoItem extends DisplayItem {
		override public function updateContent():void {
			super.updateContent();
			cropSourceImage();
		}
		
		private function cropSourceImage():void {
			var originBitmapData:BitmapData = (sourceImage_.content as Bitmap).bitmapData;
			var fillWidth:Number = vo.cropRect.width;
			var fillHeight:Number = vo.cropRect.height;
			var sourceWidth:Number = originBitmapData.width;
			var sourceHeight:Number = originBitmapData.height;
			
			var widthRatio:Number = fillWidth / sourceWidth;
			var heightRatio:Number = fillHeight / sourceHeight;
			
			var scaleRatio:Number = widthRatio;
			var translateX:Number = 0;
			var translateY:Number = (sourceHeight*scaleRatio - fillHeight) / 2.0;
			//always fill one side
			if (widthRatio < heightRatio) {
				scaleRatio = heightRatio;
				translateX = (sourceWidth*scaleRatio -fillWidth)/2.0;
				translateY = 0;
			}
			
			var matrix:Matrix = new Matrix();
			matrix.scale(scaleRatio, scaleRatio);
			matrix.translate(translateX, translateY);
			var data:BitmapData = new BitmapData(fillWidth, fillHeight, false, 0);
			data.draw(originBitmapData, matrix, null, null, null, true);
			
			var oldData:BitmapData = image_.bitmapData;
			image_.bitmapData = data;
			image_.smoothing = true;
			if (oldData != null) {
				oldData.dispose();
			}	
		}
	}
}