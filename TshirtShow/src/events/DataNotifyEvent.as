package events {
	import flash.events.Event;
	
	/**
	 *	DataNotifyEvent
	 */
	public class DataNotifyEvent extends Event {
		
		private var _data:Object;
		
		public function DataNotifyEvent(type:String, data:Object = null, bubbles:Boolean = false) {
			super(type, bubbles);
			_data = data;
		}
		
		public function get data():Object {
			return _data;
		}
		
		override public function clone(): Event {
			var event: DataNotifyEvent = new DataNotifyEvent(type, _data, this.bubbles);
			return event;
		}
	}
}