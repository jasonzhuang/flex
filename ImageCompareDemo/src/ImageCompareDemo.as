package {
	import flash.display.Sprite;
	
	import imageCompare.ImageCompareWidget;
	
	/**
	 *	ImageCompareDemo
	 */
	public class ImageCompareDemo extends Sprite {
		private var widget:ImageCompareWidget;
		
		private static const beforeURL:String = "assets/before.jpg";
		private static const afterURL:String = "assets/after.jpg";
		
		public function ImageCompareDemo()
		{
			widget = new ImageCompareWidget(beforeURL, afterURL);
/*			widget.width = 600;
			widget.height = 600;*/
			this.addChild(widget);
		}
	}
}