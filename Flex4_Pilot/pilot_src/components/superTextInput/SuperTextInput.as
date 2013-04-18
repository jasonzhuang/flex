package components.superTextInput {
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	
	import spark.components.Button;
	import spark.components.Label;
	import spark.components.TextInput;
	import spark.events.TextOperationEvent;
	
	[SkinState("prompting")]
	public class SuperTextInput extends TextInput {
		
		[SkinPart("false")]
		public var promptDisplayLabel:Label;
		
		[SkinPart("false")]
		public var clearButton:Button;
		
		private var _promptLabel:String = '';
		private var _focused:Boolean = false;
		
		public function SuperTextInput() {
			super();
			
			//watch for programmatic changes to text property
			this.addEventListener(FlexEvent.VALUE_COMMIT, textChangedHandler, false, 0, true);
			
			//watch for user changes (aka typing) to text property
			this.addEventListener(TextOperationEvent.CHANGE, textChangedHandler, false, 0, true);
		}
		
		[Bindable]
		public function get promptLabel():String {
			return _promptLabel;
		}
		
		public function set promptLabel(value:String):void {
			if (_promptLabel != value) {
				_promptLabel = value;
				if (promptDisplayLabel != null) {
					promptDisplayLabel.text = value;
				}
			}
		}
		
		private function textChangedHandler(e:Event):void {
			if (clearButton) {
				clearButton.visible = (text.length > 0);
			}
			invalidateSkinState();
		}
		
		private function clearClick(e:MouseEvent):void {
			text = '';
		}
		
		override protected function focusInHandler(event:FocusEvent):void {
			super.focusInHandler(event);
			_focused = true;
			invalidateSkinState();
		}
		
		override protected function focusOutHandler(event:FocusEvent):void {
			super.focusOutHandler(event);
			_focused = false;
			invalidateSkinState();
		}
		
		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			
			if (instance == promptDisplayLabel) {
				promptDisplayLabel.text = promptLabel;
			} else if (instance == clearButton) {
				clearButton.addEventListener(MouseEvent.CLICK, clearClick);
				clearButton.visible = (text != null && text.length > 0);
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void {
			super.partRemoved(partName, instance);
			
			if (instance == clearButton) {
				clearButton.removeEventListener(MouseEvent.CLICK, clearClick);
			}
		}
		
		override protected function getCurrentSkinState():String {
			if (promptLabel.length > 0 && text.length == 0 && !_focused) {
				return 'prompting';
			}
			return super.getCurrentSkinState();
		}
	}
}

