package components.layout
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.core.ILayoutElement;
	
	import spark.components.supportClasses.GroupBase;
	import spark.core.NavigationUnit;
	import spark.layouts.supportClasses.LayoutBase;
	
	public class SimpleVirtualHorizontalLayout extends LayoutBase
	{
		
		private var minEligibleScrollPosition:Number = 0;
		private var maxEligibleScrollPosition:Number = 0;
		
		override protected  function getHorizontalScrollPositionDelta(navigationUnit:uint):Number {
			super.getHorizontalScrollPositionDelta(navigationUnit);
		}
		
		override public function getScrollPositionDeltaToElement(index:int):Point {
			return super.getScrollPositionDeltaToElement(index);
		}
		
		/**
		 *  Called when the user clicks on the left scroll button or the left part of the track of the scrollbar 
		 */
		override protected function getElementBoundsLeftOfScrollRect(scrollRect:Rectangle):Rectangle
		{
			var offset:Number = horizontalScrollPosition % typicalLayoutElement.getLayoutBoundsWidth();
			
			var width:Number = typicalLayoutElement.getLayoutBoundsWidth();
			var height:Number = typicalLayoutElement.getLayoutBoundsHeight();
			
			return new Rectangle(scrollRect.x - width + offset,scrollRect.y,width,height);
		}
		
		/**
		 *  Called when the user clicks on the right scroll button or the right part of the track of the scrollbar
		 */
		override protected function getElementBoundsRightOfScrollRect(scrollRect:Rectangle):Rectangle
		{
			var offset:Number = horizontalScrollPosition % typicalLayoutElement.getLayoutBoundsWidth();
			
			var width:Number = typicalLayoutElement.getLayoutBoundsWidth();
			var height:Number = typicalLayoutElement.getLayoutBoundsHeight();
			
			return new Rectangle(scrollRect.right + width - offset,scrollRect.y,width,height);
		}
		
		/**
		 * TODO: This works with getNavigationDestinationIndex() for keyboard scrolling a List based target.
		 * 
		 * Given this layout's assumptions this method easily handles both the virtual and non-virtual case 
		 * since an element's position can be calculated solely by its index and the typicalLayoutElement width 
		 * 
		 */
		override public function getElementBounds(index:int):Rectangle
		{
			if (!target)
				return null;
			
			if ((index < 0) || (index >= target.numElements))
				return null;
			
			var eltX:Number = typicalLayoutElement.getLayoutBoundsWidth() * index;
			var eltY:Number = 0;
			var eltW:Number = typicalLayoutElement.getLayoutBoundsWidth()
			var eltH:Number = typicalLayoutElement.getLayoutBoundsHeight();
			
			return new Rectangle(eltX, eltY, eltW, eltH);
		}
		
		/**
		 * 
		 * This method is used by subclasses of ListBase to handle keyboard navigation. Given a current index
		 * (the index that is currently focused) this method returns the index to navigate to given a keyboard
		 * navigation command like LEFT/RIGHT/HOME/END.
		 * 
		 */  
		override public function getNavigationDestinationIndex(currentIndex:int, navigationUnit:uint, arrowKeysWrapFocus:Boolean):int
		{
			if (!target || target.numElements < 1)
				return -1; 
			
			// When the user hits the PAGE keys we need to decide how many indices it should skip
			// forward or backwards, for this simple layout we just skip by roughly the number of items in view
			var indicesPerPage:int = target.getLayoutBoundsWidth() / typicalLayoutElement.getLayoutBoundsWidth();
			
			switch (navigationUnit)
			{
				// the first index
				case NavigationUnit.HOME:
					return 0;
					
					// the last index
				case NavigationUnit.END:
					return target.numElements - 1;
					
					// one less than the currrent index
				case NavigationUnit.LEFT:
					return Math.max(0, currentIndex - 1); 
					
					// one more than the current index
				case NavigationUnit.RIGHT:
					return Math.min(target.numElements - 1, currentIndex + 1); 
					
					// a few less than the current index
				case NavigationUnit.PAGE_UP:
				case NavigationUnit.PAGE_LEFT:
					return Math.max(0, currentIndex - indicesPerPage);
					
					// a few more than the current index
				case NavigationUnit.PAGE_DOWN:
				case NavigationUnit.PAGE_RIGHT:
					return Math.min(target.numElements - 1, currentIndex + indicesPerPage); 
					
				default:
					return -1;
			}
		}
		
		override public function measure():void
		{
			if (!target)
				return;
			
			if (useVirtualLayout)
				measureVirtual(target);
			else 
				measureReal(target);
			
			// Use Math.ceil() to make sure that if the content partially occupies
			// the last pixel, we'll count it as if the whole pixel is occupied.
			target.measuredWidth = Math.ceil(target.measuredWidth);    
			target.measuredHeight = Math.ceil(target.measuredHeight);    
			target.measuredMinWidth = Math.ceil(target.measuredMinWidth);    
			target.measuredMinHeight = Math.ceil(target.measuredMinHeight);    
		}
		
		/**
		 *  Compute potentially approximate values for measuredWidth,Height and 
		 *  measuredMinWidth,Height.
		 * 
		 *  This method does not get layout elements from the target except
		 *  as a side effect of calling typicalLayoutElement.
		 * 
		 *  It assumes all elements are of equal size and equal to the size of the 
		 *  typicalLayoutElement.
		 */
		private function measureVirtual(layoutTarget:GroupBase):void
		{
			var eltCount:uint = layoutTarget.numElements;
			
			layoutTarget.measuredWidth = (eltCount * typicalLayoutElement.getLayoutBoundsWidth());
			layoutTarget.measuredHeight = typicalLayoutElement.getLayoutBoundsHeight();
			
			layoutTarget.measuredMinWidth = layoutTarget.measuredWidth;
			layoutTarget.measuredMinHeight = layoutTarget.measuredHeight;
		}
		
		/**
		 *  Compute exact values for measuredWidth,Height and measuredMinWidth,Height.
		 *  
		 *  Measure each of the layout elements. We then only 
		 *  consider the height of the elements remaining.
		 */
		private function measureReal(layoutTarget:GroupBase):void
		{
			var preferredHeight:Number = 0; // max of the elements' preferred widths
			var preferredWidth:Number = 0;  // sum of the elements' preferred heights
			var minHeight:Number = 0;       // max of the elements' minimum widths
			var minWidth:Number = 0;        // sum of the elements' minimum heights
			
			var element:ILayoutElement;
			
			for (var i:int = 0; i < layoutTarget.numElements; i++)
			{
				element = layoutTarget.getElementAt(i);
				if (!element || !element.includeInLayout)
					continue;
				
				// Consider the size of each element
				preferredWidth += element.getPreferredBoundsWidth();
				preferredHeight = Math.max(preferredHeight, element.getPreferredBoundsHeight());
				
				minWidth += element.getMinBoundsHeight();
				minHeight = Math.max(minHeight, element.getMinBoundsHeight());
				
			}
			
			layoutTarget.measuredHeight = preferredHeight;
			layoutTarget.measuredWidth = preferredWidth;
			layoutTarget.measuredMinHeight = minHeight;
			layoutTarget.measuredMinWidth  = minWidth;
		}
		
		override public function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			if (!target)
				return;
			
			if (!typicalLayoutElement)
				return;
			
			if (target.numElements <= 0)
				return;
			
			if (useVirtualLayout)
				updateDisplayListVirtual(unscaledWidth, unscaledHeight);
			else 
				updateDisplayListReal(unscaledWidth, unscaledHeight);
			
		}
		
		/**
		 * Gets called by updateDisplayList when useVirtualLayout = true
		 * 
		 * NOTE: Assumes all elements are of equal size and equal to the typicalLayoutElement
		 */
		private function updateDisplayListVirtual(containerWidth:Number, containerHeight:Number):void {
			
			// Step 1: Figure out what we are given: 
			//      - target.horizontalScrollPosition
			//      - target.width
			//      - typicalLayoutElement.getLayoutBoundsWidth();
			
			var firstIndexInView:int = 0;
			var firstIndexInViewOffset:Number = 0;
			var lastIndexInView:int = 0;
			var numIndicesInView:int = 0;
			
			// Step 2: Given the scroll position, figure out the first index that should be in view
			// keep track of the remainder in case the first index is only partially in view
			
			firstIndexInView = target.horizontalScrollPosition / typicalLayoutElement.getLayoutBoundsWidth();
			firstIndexInViewOffset = target.horizontalScrollPosition % typicalLayoutElement.getLayoutBoundsWidth();
			
			// Step 3: Figure out how many indices are in view
			
			numIndicesInView = Math.ceil(target.width / typicalLayoutElement.getLayoutBoundsWidth());
			
			// Step 4: Figure out the last index in view
			
			lastIndexInView = Math.min(firstIndexInView + numIndicesInView, target.numElements - 1);
			
			// Step 5: Figure out what coordinates to position the first index at
			
			var x:Number = target.horizontalScrollPosition - firstIndexInViewOffset;
			var y:Number = 0;
			
			// Step 6: Position the renderer of each index that is in view using getVirtualElementAt
			
			//  loop through each index that is in view
			for (var k:int = firstIndexInView; k <= lastIndexInView; k++)
			{
				// WARNING: getVirtualElementAt() should NEVER be called outside of 
				// the updateDisplayList() method of the layout
				var element:ILayoutElement = target.getVirtualElementAt(k);
				
				// position the element
				element.setLayoutBoundsPosition(x, y);
				
				// resize the element to its preferred size by passing
				// NaN for the width and height constraints
				element.setLayoutBoundsSize(NaN, NaN);
				
				// find the size of the element
				var elementWidth:Number = element.getLayoutBoundsWidth();
				var elementHeight:Number = element.getLayoutBoundsHeight();
				
				// update the target's contentWidth and contentHeight
				target.setContentSize(Math.ceil(typicalLayoutElement.getLayoutBoundsWidth() * target.numElements), 
					Math.ceil(Math.max(elementHeight, target.contentHeight)));
				
				// update the x position for where to place the next element
				x += elementWidth;
			}
			
			
			//
			// Step 7: Keep track of the extent of the renderers that are partially in view
			//
			// ie: how much they stick out of view. Keeping track of that allows us to call  
			// invalidateDisplayList() less in scrollPositionChanged().
			//
			
			minEligibleScrollPosition = target.horizontalScrollPosition;
			maxEligibleScrollPosition = minEligibleScrollPosition + target.width;
			
			// now subtract the left offset
			minEligibleScrollPosition -= firstIndexInViewOffset;
			// and add the right offset
			maxEligibleScrollPosition += typicalLayoutElement.getLayoutBoundsWidth() - firstIndexInViewOffset;
			
		}
		
		/**
		 * Gets called by updateDisplayList when useVirtualLayout = false
		 */
		private function updateDisplayListReal(containerWidth:Number, containerHeight:Number):void {
			// the x value to position the next element at
			var x:Number = 0;
			
			// the y value to position the next element at
			var y:Number = 0;
			
			// loop through every element (even those not in view) 
			for (var k:int = 0; k < target.numElements; k++)
			{
				var element:ILayoutElement = target.getElementAt(k);
				
				// position the element
				element.setLayoutBoundsPosition(x, y);
				
				// resize the element to its preferred size by passing
				// NaN for the width and height constraints
				element.setLayoutBoundsSize(NaN, NaN);
				
				// find the size of the element
				var elementWidth:Number = element.getLayoutBoundsWidth();
				var elementHeight:Number = element.getLayoutBoundsHeight();
				
				// update the layoutTarget's contentWidth and contentHeight
				target.setContentSize(Math.ceil(x + elementWidth), 
					Math.ceil(Math.max(elementHeight, target.contentHeight)));
				
				// update the x position for where to place the next element
				x += elementWidth;
				
			}
			
		}
		
		/**
		 * In a virtual layout you need to invalidate the display list if the user has
		 * scrolled by a large enough distance to expose items that don't currently 
		 * have renderers created.  We keep track of this range of scroll positions 
		 * using minEligibleScrollPosition/maxEligibleScrollPosition.
		 */
		override protected function scrollPositionChanged():void
		{
			super.scrollPositionChanged();
			
			if (!target)
				return;     
			
			if (useVirtualLayout){
				
				// an optimization: only invalidate the display list if the scroll position 
				// has changed enough that new items are coming into view
				
				if (horizontalScrollPosition < minEligibleScrollPosition || 
					horizontalScrollPosition > maxEligibleScrollPosition - target.width){
					
					target.invalidateDisplayList();
				}
			}
			
		}
	}
	
}