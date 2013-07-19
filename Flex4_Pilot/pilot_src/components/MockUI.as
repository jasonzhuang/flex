package components {
	import mx.controls.Label;
	import mx.core.UIComponent;
	
	/**
	 *	MockUI
	 */
	public class MockUI extends UIComponent {
		private var label:Label;

		private var _text:String = "mock";
		private var textChanged:Boolean = false;
		
		public function set text(value:String):void {
			if(value == _text) {
				return;
			}
			
			_text = value;
			textChanged = true;
			invalidateProperties();
		}
		
		public function get text():String {
			return _text;
		}
		
		override protected function createChildren():void {
			super.createChildren();
			
			label = new Label();
			addChild(label);
		}

		override protected function measure():void {
			super.measure();
			trace("trigger measure");
			this.measuredMinHeight = this.measuredHeight = 200;
			this.measuredMinWidth = this.measuredWidth = 200;
		}
		
		override protected function commitProperties():void {
			super.commitProperties();
			trace("triggger commitProperties")
			
			if(textChanged) {
				textChanged = false;
				label.text = _text;
			}
		}
		
		/**
		* 0.the position(x,y) proportion is scale as well, for instance, the first
		*  slot picture position is (121,128), when set the scale to 1.3, the position
		*  will be (158,166)
		*1..unscaledWidth and unscaledHeight: They come from an explicit height/width  OR  the values determined in the measure method 
		*  OR they’re determined through measuring done by the component's parent.
        *
		* 2.Basic sizing property rules: http://livedocs.adobe.com/flex/3/html/help.html?content=size_position_3.html
		* 3. only set width, then the explicitWidth will be the same value
		*/
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			trace("trigger updateDisplayList");
			label.width = unscaledWidth/2.0;
			label.height = unscaledHeight/2.0;
			label.x = unscaledWidth/2.0;
			label.y = unscaledHeight/2.0;
			
			graphics.clear();
			graphics.lineStyle(2, 0xffff00);
			graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
			graphics.beginFill(0xff0000, 1);
			graphics.drawRect(0,0,unscaledWidth, unscaledHeight);
			graphics.endFill();
		}
	}
}