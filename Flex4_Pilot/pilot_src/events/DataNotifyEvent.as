package events {
	import flash.events.Event;
	
	/**
	 *	DataNotifyEvent
	 */
	public class DataNotifyEvent extends Event {
		private var _data:Object;
		
		public function DataNotifyEvent(type:String, data:Object = null, bubbles:Boolean = true)
		{
			this._data = data;
			super(type, bubbles);
		}
		
		public function get data():Object {
			return this._data;
		}
		
		override public function clone():Event {
			return new DataNotifyEvent(this.type, this._data, this.bubbles);
		}
	}
}