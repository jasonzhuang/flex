package com.netease {
	import flash.events.Event;
	
	/**
	 *	DataNotifyEvent
	 */
	public class DataNotifyEvent extends Event {
		private var _data:Object;
		
		public function get data():Object {
			return _data;
		}
		
		public function DataNotifyEvent(type:String, data:Object = null, bubbles:Boolean = true)
		{
			super(type, bubbles);
			this._data = data;
		}
		
		override public function clone():Event {
			return new DataNotifyEvent(this.type, this._data, this.bubbles);
		}
		
		//===============Event Names===================//
		public static const CONFIG_LOADED:String = "configLoaded";
	}
}