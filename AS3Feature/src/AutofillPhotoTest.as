package {
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import views.autofill.DisplayItem;
	import views.autofill.DisplayObjectVO;
	import views.autofill.PhotoItem;
	
	/**
	 *	AutofillPhoto
	 */
	public class AutofillPhotoTest extends Sprite {
		private static const BACK_URL:String = "assets/te124122.png";
		private static const SLOT_URL:String = "assets/test.jpg";
		
		public function AutofillPhotoTest()
		{
			buildBackgound();
			buildSlot();
		}
		
		private function buildBackgound():void {
			var item:DisplayItem = new DisplayItem();
			var backVO:DisplayObjectVO = new DisplayObjectVO();
			backVO.url = BACK_URL;
			backVO.x = 0;
			backVO.y = 0;
			item.vo = backVO;
			addChild(item);
			item.load();
		}
		
		private function buildSlot():void {
			var item:PhotoItem = new PhotoItem();
			var slotVO:DisplayObjectVO = new DisplayObjectVO();
			slotVO.url = SLOT_URL;
			slotVO.x = 57;
			slotVO.y = 50;
			slotVO.rotation = 0;
			var cropRect:Rectangle = new Rectangle(0,0,105,76);
			slotVO.cropRect = cropRect;
			item.vo = slotVO;
			addChild(item);
			item.load();
		}
	}
}