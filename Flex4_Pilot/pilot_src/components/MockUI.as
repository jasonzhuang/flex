package components {
	import mx.core.UIComponent;
	
	/**
	 *	MockUI
	 */
	public class MockUI extends UIComponent {
		/**
		* 0.the position(x,y) proportion is scale as well, for instance, the first
		*  slot picture position is (121,128), when set the scale to 1.3, the position
		*  will be (158,166)
        * 1.when not set width value, unscaledWidth = width = measuredWidth
        * 2.when width or height is explictly assigned, unscaledWidth = width, measuredWidth value is calculated.
        * 3.when width is set by percent, if the result is smaller than measuredWidth, unscaledWidth = width = measuredWidth
        *    otherwise, unscaledWidth = width = parent width * percent, measuredWidth value is calculated.
        * 4.explicitWidth has value only when width is setted, if width is set by percent or no width is set, the explicitWidth is NaN
		* 5.change size will trigger updateDisplayList(), change scale will NOT trigger it.
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