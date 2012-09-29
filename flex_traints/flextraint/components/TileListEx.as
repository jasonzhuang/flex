package components
{
	import flash.display.Sprite;
	
	import mx.controls.TileList;
	import mx.controls.listClasses.IListItemRenderer;
	
	public class TileListEx extends TileList
	{
/*		override protected function drawSelectionIndicator(indicator:Sprite, x:Number,
														   y:Number, width:Number, height:Number, color:uint,
														   itemRenderer:IListItemRenderer):void
		{
			return;
		}*/
		
		/**
		 * disable rollover color
		 */
		override protected function drawHighlightIndicator(indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer):void {
			return;
		}
	}
}