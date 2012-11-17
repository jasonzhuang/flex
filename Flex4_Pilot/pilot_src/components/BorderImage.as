package components
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Image;
	
	[Style(name="itemOverColor", type="uint", format="Color", inherit="no")]
	[Style(name="selectionColor", type="uint", format="Color", inherit="no")]
	[Style(name="borderThickness", type="Number",format="Length", inherit="no")]
	[Style(name="borderAlpha", type="Number", format="Length", inherit="no")]
	public class BorderImage extends Image
	{
		private var _recalX:Number;
		private var _recalY:Number;
		
		
		
		public function BorderImage(){
			this.addEventListener(MouseEvent.ROLL_OVER, mouseEventHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, mouseEventHandler);
			this.addEventListener(MouseEvent.CLICK, mouseEventHandler);
		}
		
		/**
		 *  @private
		 *  Storage for the hovered property 
		 */
		private var _hovered:Boolean = false;    
		
		/**
		 *  Indicates whether the mouse pointer is over the Image.
		 *  Used to determine the skin state.
		 */ 
		protected function get hovered():Boolean
		{
			return _hovered;
		}
		
		/**
		 *  @private
		 */ 
		protected function set hovered(value:Boolean):void
		{
			if (value == _hovered) {
				return;
			}
			
			_hovered = value;
			this.invalidateProperties();
			this.invalidateDisplayList();
		}
		
		private var _itemSelected:Boolean = false;
		
		[Bindable("itemSelected")]
		public function set itemSelected(value:Boolean):void {
			if(value == _itemSelected) {
				return;
			}
			
			_itemSelected = value;
			this.dispatchEvent(new Event("itemSelected"));
			this.invalidateProperties();
			this.invalidateDisplayList();
		}
		
		public function get itemSelected():Boolean {
			return _itemSelected;
		}
		
		protected function mouseEventHandler(event:Event):void {
			var mouseEvent:MouseEvent = event as MouseEvent;
			switch (event.type) {
				case MouseEvent.ROLL_OVER:{
					hovered = true;
					break;
				}
					
				case MouseEvent.ROLL_OUT: {
					hovered = false;
					break;
				}
					
				case MouseEvent.CLICK: {
					itemSelected = true;
					clickHandler(mouseEvent);
					break;
				}
			}
			
			if (mouseEvent) {
				mouseEvent.updateAfterEvent();
			}
		}
		
		private var highlightIndicator:Shape;
		private var selectionIndicators:Shape;
		
		override protected function createChildren():void {
			if(!highlightIndicator) {
				highlightIndicator = new Shape();
				this.addChildAt(highlightIndicator, 0);
			}
			
			if(!selectionIndicators) {
				selectionIndicators = new Shape();
				this.addChildAt(selectionIndicators, 0);
			}
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			if(hovered) {
				drawIndicator(highlightIndicator, getStyle('itemOverColor'));
			} else if(!hovered){
				clearIndicator(highlightIndicator);
			}

			if(itemSelected) {
				drawIndicator(selectionIndicators, getStyle('selectionColor'));
			} else if(!itemSelected)
				clearIndicator(selectionIndicators);
		}
		
		private function drawIndicator(indicator:Shape, color:uint):void {
			x = _recalX + (getStyle('borderThickness'));
			y = _recalY + (getStyle('borderThickness'));
			
			var g:Graphics = indicator.graphics;
			g.clear();
			g.lineStyle(0, color, 0, false);
			g.beginFill(color, getStyle('borderAlpha'));
			g.drawRect(-getStyle('borderThickness'), -getStyle('borderThickness'), contentWidth+getStyle('borderThickness')*2, contentHeight+getStyle('borderThickness')*2);
			g.endFill();
		}
		
		private function clearIndicator(indicator:Shape):void {
			var g:Graphics = indicator.graphics;
			g.clear();
		}
	}
}