package components {
	import mx.core.UIComponent;
	
	/**
	 *	MockUI
	 */
	public class MockUI extends UIComponent {
		/**
		 * change size will trigger updateDisplayList(), change scale will NOT trigger it.
		 */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			graphics.clear();
			graphics.beginFill(0xff0000, 1);
			graphics.drawRect(0,0,unscaledWidth, unscaledHeight);
			graphics.endFill();
			trace("trigger it");
		}
	}
}