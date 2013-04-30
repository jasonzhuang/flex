package components.browserTab {
	import components.browserTab.TerrificTabBarEvent;
	
	import flash.events.MouseEvent;
	
	import spark.components.Button;
	import spark.components.ButtonBarButton;
	import spark.components.Label;
	
	[Event('closeTab',type='events.TerrificTabBarEvent')]
	
	public class TerrificTabBarButton extends ButtonBarButton {
		[SkinPart("false")]
		public var closeButton:Button;
		
		private var _closeable:Boolean = true;
		
		public function TerrificTabBarButton() {
			super();
			
			//NOTE: this enables the button's children (aka the close button) to receive mouse events
			this.mouseChildren = true;
		}
		
		[Bindable]
		public function get closeable():Boolean {
			return _closeable;
		}
		
		public function set closeable(val:Boolean):void {
			if (_closeable != val) {
				_closeable = val;
				closeButton.visible = val;
				Label(labelDisplay).right = (val ? 30 : 14);
			}
		}
		
		private function closeHandler(e:MouseEvent):void {
			dispatchEvent(new TerrificTabBarEvent(TerrificTabBarEvent.CLOSE_TAB, itemIndex, true));
		}
		
		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			
			if (instance == closeButton) {
				closeButton.addEventListener(MouseEvent.CLICK, closeHandler);
				closeButton.visible = closeable;
			} else if (instance == labelDisplay) {
				Label(labelDisplay).right = (closeable ? 30 : 14);
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void {
			super.partRemoved(partName, instance);
			
			if (instance == closeButton) {
				closeButton.removeEventListener(MouseEvent.CLICK, closeHandler);
			}
		}
	}
}