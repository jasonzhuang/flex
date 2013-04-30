package components.dragableTab {
	import flash.events.Event;
	
	public class CustomTabBarReorderEvent extends Event {
		
		public static const TAB_REORDERED:String = 'tabReordered';
		
		public var oldIndex:int = -1;
		public var newIndex:int = -1;
		
		public function CustomTabBarReorderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			var e:CustomTabBarReorderEvent = new CustomTabBarReorderEvent(type, bubbles, cancelable);
			e.oldIndex = oldIndex;
			e.newIndex = newIndex;
			
			return e;
		}
	}
}