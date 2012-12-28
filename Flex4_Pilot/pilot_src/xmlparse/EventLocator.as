package xmlparse {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 *	EventLocator
	 */
	public class EventLocator {
		private static var _instance:EventLocator;
		
		private var eventDispatcher: EventDispatcher = new EventDispatcher();
		
		public static function getInstance():EventLocator {
			if(!_instance) {
				_instance = new EventLocator();
			}
			
			return _instance;
		}
		
		public  function dispatchEvent(event:DataNotifyEvent):Boolean
		{
			return eventDispatcher.dispatchEvent(event);
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true):void
		{
			eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}
	}
}