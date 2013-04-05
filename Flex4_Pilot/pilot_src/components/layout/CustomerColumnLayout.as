package components.layout
{
	import spark.layouts.supportClasses.LayoutBase;
	import spark.components.supportClasses.GroupBase;
	import mx.core.ILayoutElement;
	
	/**
	 * Scenario: First row has only one item, and its size is bigger than the other rows
	 * The other rows has two items
	 */
	public class CustomerColumnLayout extends LayoutBase
	{
		//hardcoded variables
		public var columnCount:int = 2;
		
		//for first special item
		private var bigTileWidth:Number = 120;
		private var bigTileHeight:Number = 120;
		//for the others item
		private var smallTileWidth:Number = 80;
		private var smallTileHeight:Number = 100;
		
		
		override public function updateDisplayList(width:Number, height:Number):void {
			var layoutTarget:GroupBase = target;
			if (!layoutTarget) {
				return;
			}
			
			var numElements:int = layoutTarget.numElements;
			if (!numElements) {
				return;
			}
			
			//position and size the first element
			var el:ILayoutElement = useVirtualLayout ? 
				layoutTarget.getVirtualElementAt(0) : layoutTarget.getElementAt(0);
			el.setLayoutBoundsSize(bigTileWidth, bigTileHeight);
			el.setLayoutBoundsPosition(0, 0);
			
			//position & size the other elements in 2 columns below the 1st element
			for (var i:int=1; i<numElements; i++) {
				var x:Number = smallTileWidth  * ((i-1) % columnCount);
				var y:Number = smallTileHeight * Math.floor((i-1) / columnCount) + bigTileHeight;
				
				el = useVirtualLayout ? 
					layoutTarget.getVirtualElementAt(i) : 
					layoutTarget.getElementAt(i);
				el.setLayoutBoundsSize(smallTileWidth, smallTileHeight);
				el.setLayoutBoundsPosition(x, y);
			}
			
			//set the content size (necessary for scrolling)
			layoutTarget.setContentSize(
				layoutTarget.measuredWidth, layoutTarget.measuredHeight
			);
		}
		
		override public function measure():void {
			var layoutTarget:GroupBase = target;
			if (!layoutTarget) {
				return;
			}
			
			var rowCount:int = Math.ceil((layoutTarget.numElements - 1) / 2);
			
			//measure the total width and height
			layoutTarget.measuredWidth = layoutTarget.measuredMinWidth = 
				Math.max(smallTileWidth * columnCount, bigTileWidth);
			layoutTarget.measuredHeight = layoutTarget.measuredMinHeight = 
				bigTileHeight + smallTileHeight * rowCount;
		}
		
	}
}