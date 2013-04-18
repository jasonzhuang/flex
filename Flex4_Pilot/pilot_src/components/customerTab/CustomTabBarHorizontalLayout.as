package components.customerTab {
	import flash.geom.Rectangle;
	
	import mx.core.IVisualElement;
	
	import spark.components.supportClasses.ButtonBarHorizontalLayout;
	import spark.components.supportClasses.GroupBase;
	import spark.layouts.supportClasses.DropLocation;
	
	public class CustomTabBarHorizontalLayout extends ButtonBarHorizontalLayout {
		
		public var draggingIndex:int = -10;
		
		public function CustomTabBarHorizontalLayout() {
			super();
		}
		
		
		override protected function calculateDropIndex(x:Number, y:Number):int {
			// Iterate over the visible elements
			var layoutTarget:GroupBase = target;
			var count:int = layoutTarget.numElements;
			
			// If there are no items, insert at index 0
			if (count == 0)
				return 0;
			
			// Go through the visible elements
			var minDistance:Number = Number.MAX_VALUE;
			var bestIndex:int = -1;
			
			//var start:int = this.firstIndexInView;
			//var end:int = this.lastIndexInView;
			
			//set start to 0 and end to numElements-1 because there is no scrolling going on in this TabBar
			var start:int = 0;
			var end:int = layoutTarget.numElements-1;
			
			for (var i:int = start; i <= end; i++)
			{
				var elementBounds:Rectangle = this.getElementBounds(i);
				if (!elementBounds){
					continue;
				}
				
				if (elementBounds.left <= x && x <= elementBounds.right)
				{
					var centerX:Number = elementBounds.x + elementBounds.width / 2;
					return (x < centerX) ? i : i + 1;
				}
				
				var curDistance:Number = Math.min(Math.abs(x - elementBounds.left),
					Math.abs(x - elementBounds.right));
				if (curDistance < minDistance)
				{
					minDistance = curDistance;
					bestIndex = (x < elementBounds.left) ? i : i + 1;
				}
			}
			
			// If there are no visible elements, either pick to drop at the beginning or at the end
			if (bestIndex == -1)
				bestIndex = getElementBounds(0).x < x ? count : 0;
			
			return bestIndex;
			
		}
		
		override protected function calculateDropIndicatorBounds(dropLocation:DropLocation):Rectangle {
			var dropIndex:int = dropLocation.dropIndex;
			
			//if the dropIndex is to the immediate left or right don't show the dropIndicator
			if((draggingIndex == dropIndex) || draggingIndex + 1 == dropIndex){
				return null;
			}
			
			var count:int = target.numElements;
			var gap:Number = this.gap;
			
			// Special case, if we insert at the end, and the gap is negative, consider it to be zero
			if (gap < 0 && dropIndex == count)
				gap = 0;
			
			var emptySpace:Number = (0 < gap ) ? gap : 0; 
			var emptySpaceLeft:Number = 0;
			if (target.numElements > 0)
			{
				emptySpaceLeft = (dropIndex < count) ? getElementBounds(dropIndex).left - emptySpace : 
					getElementBounds(dropIndex - 1).right + gap - emptySpace;
			}
			
			// Calculate the size of the bounds, take minium and maximum into account
			var width:Number = emptySpace;
			//var height:Number = Math.max(target.height, target.contentHeight) - paddingTop - paddingBottom;
			var height:Number = Math.max(target.height, target.contentHeight);
			if (dropIndicator is IVisualElement)
			{
				var element:IVisualElement = IVisualElement(dropIndicator);
				width = Math.max(Math.min(width, element.getMaxBoundsWidth(false)), element.getMinBoundsWidth(false));
			}
			
			var x:Number = emptySpaceLeft + Math.round((emptySpace - width)/2);
			// Allow 1 pixel overlap with container border
			x = Math.max(-Math.ceil(width / 2), Math.min(target.contentWidth - Math.ceil(width/2), x));
			
			//var y:Number = paddingTop;
			var y:Number = 0;
			return new Rectangle(x, y, width, height);
		}
		
		
	}
}