package components
{
	import mx.containers.VBox;
	import mx.utils.GraphicsUtil;
	
	public class RoundVBox extends VBox
	{
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			graphics.clear();
			graphics.beginFill(0xf7f7f7);
			GraphicsUtil.drawRoundRectComplex(graphics,0,0,unscaledWidth,unscaledHeight,0,0,10,10)
			graphics.endFill();
		}
		
		public function set backgroudColor(color:uint):void {
			this.setStyle("backgroudColor", color);
		}
	}
}