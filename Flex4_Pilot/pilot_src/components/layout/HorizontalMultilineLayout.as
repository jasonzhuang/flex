package com.netease.view.common {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.core.ILayoutElement;
	import mx.core.IVisualElement;
	
	import spark.components.supportClasses.GroupBase;
	import spark.layouts.RowAlign;
	import spark.layouts.VerticalAlign;
	import spark.layouts.supportClasses.DropLocation;
	import spark.layouts.supportClasses.LayoutBase;
	
	/**
	 * 
	 * 由于TileLayout在不指定columnCount或rowCount时, 会有较大空隙出现, 故需要实现自定义的layout
	 *
	 * 特征: 像TextAera文本输入, 一行满了后自动换行. 做到自适应布局
	 * 同时支持drag-drop操作
	 */
	public class HorizontalMultilineLayout extends LayoutBase
	{
		private var _rowCount:int = -1;
		private var _columnCount:int = -1;
		
		//container width
		private var lastWidth:Number = -1;
		
		private var _horizontalGap:Number = 6;
		
		public function get horizontalGap():Number
		{
			return _horizontalGap;
		}
		
		public function set horizontalGap(value:Number):void
		{
			if (value == _horizontalGap)
				return;
			
			_horizontalGap = value;
			invalidateTargetSizeAndDisplayList();
		}
		
		private var _verticalGap:Number = 6;
		
		public function get verticalGap():Number
		{
			return _verticalGap;
		}
		
		public function set verticalGap(value:Number):void
		{
			if (value == _verticalGap)
				return;
			
			_verticalGap = value;
			invalidateTargetSizeAndDisplayList();
		}
		
		private var _verticalAlign:String = VerticalAlign.TOP;
		
		[Inspectable(category="General", enumeration="top,bottom,middle", defaultValue="top")]
		public function get verticalAlign():String
		{
			return _verticalAlign;
		}
		
		public function set verticalAlign(value:String):void
		{
			if (_verticalAlign == value)
				return;
			
			_verticalAlign = value;
			invalidateTargetSizeAndDisplayList();
		}
		
		private var _paddingLeft:Number = 0;
		
		public function get paddingLeft():Number
		{
			return _paddingLeft;
		}
		
		public function set paddingLeft(value:Number):void
		{
			if (_paddingLeft == value)
				return;
			
			_paddingLeft = value;
			invalidateTargetSizeAndDisplayList();
		}    
		
		private var _paddingRight:Number = 0;
		
		public function get paddingRight():Number
		{
			return _paddingRight;
		}
		
		public function set paddingRight(value:Number):void
		{
			if (_paddingRight == value)
				return;
			
			_paddingRight = value;
			invalidateTargetSizeAndDisplayList();
		}    
		
		private var _paddingTop:Number = 0;
		
		public function get paddingTop():Number
		{
			return _paddingTop;
		}
		
		public function set paddingTop(value:Number):void
		{
			if (_paddingTop == value)
				return;
			
			_paddingTop = value;
			invalidateTargetSizeAndDisplayList();
		}    
		
		private var _paddingBottom:Number = 0;
		
		public function get paddingBottom():Number
		{
			return _paddingBottom;
		}
		
		public function set paddingBottom(value:Number):void
		{
			if (_paddingBottom == value)
				return;
			
			_paddingBottom = value;
			invalidateTargetSizeAndDisplayList();
		}    
		
		override public function measure():void
		{
			if (lastWidth == -1) {
				return;
			}
			
			var measuredWidth:Number = 0;
			var measuredMinWidth:Number = 0;
			var measuredHeight:Number = 0;
			var measuredMinHeight:Number = 0;
			
			var layoutTarget:GroupBase = target;
			var n:int = layoutTarget.numElements;
			var element:ILayoutElement;
			var i:int;
			var width:Number = layoutTarget.explicitWidth;
			if (isNaN(width) && lastWidth != -1)
				width = lastWidth;
			if (isNaN(width)) // width is not defined by parent or user
			{
				// do not specify measuredWidth and measuredHeight to real
				// values because in fact we can layout at any width or height
				for (i = 0; i < n; i++)
				{
					element = useVirtualLayout ? layoutTarget.getVirtualElementAt(i) : layoutTarget.getElementAt(i);
					if (!element || !element.includeInLayout)
						continue;
					
					measuredWidth = Math.ceil(element.getPreferredBoundsWidth());
					measuredHeight = Math.ceil(element.getPreferredBoundsHeight());
					break;
				}
				measuredMinWidth = measuredWidth;
				measuredMinHeight = measuredHeight;
			}
			else
			{
				// calculate lines based on width
				var currentLineWidth:Number = 0;
				var currentLineHeight:Number = 0;
				var lineNum:int = 1;
				for (i = 0; i < n; i++)
				{
					element = useVirtualLayout ? layoutTarget.getVirtualElementAt(i) : layoutTarget.getElementAt(i);
					if (!element || !element.includeInLayout)
						continue;
					
					var widthWithoutPaddings:Number = width - _paddingLeft - _paddingRight;
					var elementWidth:Number = Math.ceil(element.getPreferredBoundsWidth());
					if (currentLineWidth == 0 || 
						currentLineWidth + _horizontalGap + elementWidth <= widthWithoutPaddings)
					{
						currentLineWidth += elementWidth + (currentLineWidth == 0 ? 0 : _horizontalGap);
						currentLineHeight = Math.max(currentLineHeight, Math.ceil(element.getPreferredBoundsHeight()));
					}
					else
					{
						measuredHeight += currentLineHeight;
						
						lineNum++;
						currentLineWidth = elementWidth;
						currentLineHeight = Math.ceil(element.getPreferredBoundsHeight());
					}
				}
				measuredHeight += currentLineHeight;
				if (lineNum > 1)
					measuredHeight += _verticalGap * (lineNum - 1);
				
				// do not set measuredWidth to real value because really we can  
				// layout at any width
				for (i = 0; i < n; i++)
				{
					element = useVirtualLayout ? layoutTarget.getVirtualElementAt(i) : layoutTarget.getElementAt(i);
					if (!element || !element.includeInLayout)
						continue;
					
					measuredWidth =
						measuredMinWidth = Math.ceil(element.getPreferredBoundsWidth());
					break;
				}
				measuredMinHeight = measuredHeight;
			}
			
			layoutTarget.measuredWidth = measuredWidth + _paddingLeft + _paddingRight;
			layoutTarget.measuredMinWidth = measuredMinWidth + _paddingLeft + _paddingRight;
			layoutTarget.measuredHeight = measuredHeight + _paddingTop + _paddingBottom;
			layoutTarget.measuredMinHeight = measuredMinHeight + _paddingTop + _paddingBottom;
		}
		
		override public function updateDisplayList(width:Number, height:Number):void
		{
			resetRowAndColumn();
			var layoutTarget:GroupBase = target;
			var n:int = layoutTarget.numElements;
			var element:ILayoutElement;
			var i:int;
			// calculate lines based on width
			var x:Number = _paddingLeft;
			var y:Number = _paddingTop;
			var maxLineHeight:Number = 0;
			var elementCounter:int = 0;
			var positions:Vector.<Point> = new Vector.<Point>();
			for (i = 0; i < n; i++)
			{
				element = useVirtualLayout ? layoutTarget.getVirtualElementAt(i) : layoutTarget.getElementAt(i);
				if (!element || !element.includeInLayout) {
					positions[i] = new Point(x, y);
					continue;
				}
				
				var elementWidth:Number = Math.ceil(element.getPreferredBoundsWidth());
				if (x == _paddingLeft || x + _horizontalGap + elementWidth <= width - _paddingRight) {
					if (elementCounter > 0)
						x += _horizontalGap;
					positions[i] = new Point(x, y);
					element.setLayoutBoundsSize(NaN, NaN);
					maxLineHeight = Math.max(maxLineHeight, Math.ceil(element.getPreferredBoundsHeight()));
					//calculate column count
					if(!startNewLine) {
						_columnCount++;
					}
				} else {
					startNewLine = true;
					_rowCount++;
					x = _paddingLeft;
					y += _verticalGap + maxLineHeight;
					maxLineHeight = Math.ceil(element.getPreferredBoundsHeight());
					positions[i] = new Point(x, y);
					element.setLayoutBoundsSize(NaN, NaN);
				}
				x += elementWidth;
				elementCounter++;
			}
			
			// verticalAlign and setLayoutBoundsPosition() for elements
			var yAdd:Number = 0;
			var yDifference:Number = height - (y + maxLineHeight + _paddingBottom);
			if (_verticalAlign == VerticalAlign.MIDDLE)
				yAdd = Math.round(yDifference / 2);
			else if (_verticalAlign == VerticalAlign.BOTTOM)
				yAdd = Math.round(yDifference);
			for (i = 0; i < n; i++)
			{
				element = useVirtualLayout ? layoutTarget.getVirtualElementAt(i) : layoutTarget.getElementAt(i);
				if (!element || !element.includeInLayout)
					continue;
				var point:Point = positions[i];
				point.y += yAdd;
				element.setLayoutBoundsPosition(point.x, point.y);
			}
			
			// if width changed then height will change too - remeasure
			if (lastWidth == -1 || lastWidth != width)
			{
				lastWidth = width;
				invalidateTargetSizeAndDisplayList();
			}
			//trace("rowCount: ---", _rowCount, " ---columnCount: ----", _columnCount);
		}
		
		private var startNewLine:Boolean = false;
		
		private function resetRowAndColumn():void {
			var num:int = target.numElements;
			if(num >0) {
				_rowCount = 1;
				_columnCount = 0;
			} else {
				_rowCount = _columnCount = 0;
			}
			startNewLine = false;
		}
		
		private function invalidateTargetSizeAndDisplayList():void
		{
			var g:GroupBase = target;
			if (!g)
				return;
			
			g.invalidateSize();
			g.invalidateDisplayList();
		}
		
		private function calculateDropCellIndex(x:Number, y:Number):Array {
			var xStart:Number = x - paddingLeft;
			var yStart:Number = y - paddingTop;
			var column:int = Math.floor(xStart / (columnWidth + _horizontalGap));
			var row:int = Math.floor(yStart / (rowHeight + _verticalGap));
			
			// Check whether x is closer to left column or right column:
			var midColumnLine:Number;
			var midRowLine:Number;
			
			midColumnLine = (column + 1) * (columnWidth + _horizontalGap) - _horizontalGap - columnWidth / 2; 
			
			// Mid-line is at the middle of the gap between the rows
			midRowLine = (row + 1) * (rowHeight + _verticalGap) - _verticalGap / 2;  
			
			if (xStart > midColumnLine)
				column++;
			if (yStart > midRowLine)
				row++;
			
			// Limit row and column, if any one is too far from the drop location
			// And there is white space
			if (column > _columnCount || row > _rowCount)
			{
				row = _rowCount;
				column = _columnCount;
			}
			
			if (column < 0)
				column = 0;
			if (row < 0)
				row = 0;
			
			if (row >= _rowCount)
				row = _rowCount - 1;
			
			return [row, column];
		}
		
		override protected function calculateDropIndex(x:Number, y:Number):int {
			var result:Array = calculateDropCellIndex(x, y);
			var row:int = result[0]; 
			var column:int = result[1]; 
			var index:int = row * _columnCount + column;
			var count:int = target.numElements;
			
			if (index > count) {
				index = count;
			}
			
			return index;
		}
		
		private function get columnWidth():Number {
			if (typicalLayoutElement == null) {
				return 0;
			}
			return typicalLayoutElement.getLayoutBoundsWidth();
		}
		
		private function get rowHeight():Number {
			if (typicalLayoutElement == null) {
				return 0;
			}
			return typicalLayoutElement.getLayoutBoundsHeight();
		}
		
		//NOTE:we do NOT use contentWidth
		override protected function calculateDropIndicatorBounds(dropLocation:DropLocation):Rectangle {
			var result:Array = calculateDropCellIndex(dropLocation.dropPoint.x, dropLocation.dropPoint.y);
			var row:int = result[0]; 
			var column:int = result[1]; 
			
			var count:int = target.numElements;
			
			// The last row may be only partially full,
			// don't drop beyond the last column.
			if (row * _columnCount + column > count)
				column = count - (_rowCount - 1) * _columnCount;
			
			var x:Number;
			var y:Number;
			var dropIndicatorElement:IVisualElement;
			var emptySpace:Number; // empty space between the elements
			
			// Start with the dropIndicator dimensions, in case it's not 
			// an IVisualElement
			var width:Number = dropIndicator.width;
			var height:Number = dropIndicator.height;
			
			emptySpace = (0 < _horizontalGap ) ? _horizontalGap : 0; 
			var emptySpaceLeft:Number = column * (columnWidth + _horizontalGap) - emptySpace;
			
			// Special case - if we have negative gap and we're the last column,
			// adjust the emptySpaceLeft
			if (_horizontalGap < 0 && (column == _columnCount || count == dropLocation.dropIndex))
				emptySpaceLeft -= _horizontalGap;
			
			width = emptySpace;
			height = rowHeight;
			// Special case - if we have negative gap and we're not the last
			// row, adjust the height
			if (_verticalGap < 0 && row < _rowCount - 1)
				height += _verticalGap + 1;
			
			if (dropIndicator is IVisualElement)
			{
				dropIndicatorElement = IVisualElement(dropIndicator);
				width = Math.max(Math.min(width,
					dropIndicatorElement.getMaxBoundsWidth(false)),
					dropIndicatorElement.getMinBoundsWidth(false));
			}
			
			x = emptySpaceLeft + Math.round((emptySpace - width) / 2) + paddingLeft;
			// Allow 1 pixel overlap with container border
			//x = Math.max(-1, Math.min(target.contentWidth - width + 1, x));
			//NOTE:we do NOT use contentWidth
			x = Math.max(-1, Math.min(target.width - width + 1, x));
			y = row * (rowHeight + _verticalGap) + paddingTop;
			return new Rectangle(x, y, width, height);
		}
	}
}