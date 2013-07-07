package components.layout {
	import mx.core.ILayoutElement;
	
	import spark.components.supportClasses.GroupBase;
	import spark.layouts.supportClasses.LayoutBase;
	
	/**
	 *	PostcardLayout
	 * DO: set container width for diffrent size, and change 
	 * measuredWidth, layoutTarget.setContentSize(), see
	 * what happen
	 */
	public class PostcardLayout extends LayoutBase {
		private var _paddingLeft:Number = 0;
		private var _paddingRight:Number = 0;
		private var _paddingTop:Number = 0;
		private var _paddingBottom:Number = 0;
		//each group gap
		private var _groupGap:Number = 20;
		
		public function get groupGap():Number
		{
			return _groupGap;
		}
		
		public function set groupGap(value:Number):void
		{
			if(value == _groupGap) {
				return;
			}
			_groupGap = value;
			invalidateTargetSizeAndDisplayList();
		}
		
		public function get paddingBottom():Number
		{
			return _paddingBottom;
		}
		
		public function set paddingBottom(value:Number):void
		{
			if(value == _paddingBottom) {
				return;
			}
			_paddingBottom = value;
			invalidateTargetSizeAndDisplayList();
		}
		
		public function get paddingTop():Number
		{
			return _paddingTop;
		}
		
		public function set paddingTop(value:Number):void
		{
			if(value == _paddingTop) {
				return;
			}
			_paddingTop = value;
			invalidateTargetSizeAndDisplayList();
		}
		
		public function get paddingRight():Number
		{
			return _paddingRight;
		}
		
		public function set paddingRight(value:Number):void
		{
			if(value == _paddingRight) {
				return;
			}
			_paddingRight = value;
			invalidateTargetSizeAndDisplayList();
		}
		
		public function get paddingLeft():Number
		{
			return _paddingLeft;
		}
		
		public function set paddingLeft(value:Number):void
		{
			if(value == _paddingLeft) {
				return;
			}
			_paddingLeft = value;
			invalidateTargetSizeAndDisplayList();
		}
		
		private function invalidateTargetSizeAndDisplayList():void
		{
			var g:GroupBase = target;
			if (!g) {
				return;
			}
			
			g.invalidateSize();
			g.invalidateDisplayList();
		}
		
		override public function measure():void {
			var totalWidth:Number = 0;
			var totalHeight:Number = 0;
			
			var layoutTarget:GroupBase = target;
			var numElements:int = layoutTarget.numElements;
			var element:ILayoutElement;
			
			for(var i:int = 0; i< numElements; i++) {
				element = useVirtualLayout ? layoutTarget.getVirtualElementAt(i) : layoutTarget.getElementAt(i);
				if(!element) {
					element = typicalLayoutElement;
				}
				
				// Find the preferred sizes    
				var elementWidth:Number = element.getPreferredBoundsWidth();
				var elementHeight:Number = element.getPreferredBoundsHeight();
				var gap:Number = needGroupGap(i) ? groupGap : 0;
				
				totalWidth += elementWidth + gap;
				totalHeight = Math.max(totalHeight, elementHeight);
			}
			
			layoutTarget.measuredWidth = layoutTarget.measuredMinWidth = totalWidth + paddingLeft + paddingRight;
			layoutTarget.measuredHeight = layoutTarget.measuredMinHeight = totalHeight + paddingTop + paddingBottom;
		}
		
		protected function needGroupGap(index:int):Boolean {
			return (index > 0) && (index%2 == 0);
		}
		
		override public function updateDisplayList(width:Number, height:Number):void {
			trace("trigger update");
			var layoutTarget:GroupBase = target;
			if (!layoutTarget) {
				return;
			}
			
			var numElements:int = layoutTarget.numElements;
			if (!numElements) {
				return;
			}
			
			var maxWidth:Number = 0;
			var maxHeight:Number = 0;
			var element:ILayoutElement;
			var x:int = paddingLeft;
			var y:int = paddingTop;
			
			//position and size element
			for(var i:int = 0; i< numElements; i++) {
				element = useVirtualLayout ? layoutTarget.getVirtualElementAt(i) : layoutTarget.getElementAt(i);
				
				var gap:Number = needGroupGap(i) ? groupGap : 0;
				
				var elementWidth:Number = element.getPreferredBoundsWidth();
				var elementHeight:Number = element.getPreferredBoundsHeight();
				
				element.setLayoutBoundsPosition(x + gap, y);
				element.setLayoutBoundsSize(NaN, NaN);
				
				maxWidth = Math.max(maxWidth, x + elementWidth + gap);
				maxHeight = Math.max(maxHeight, y + elementHeight);
				
				x += elementWidth + gap;
			}
			
			//scrolling support
			layoutTarget.setContentSize(maxWidth, maxHeight);
		}
	}
}