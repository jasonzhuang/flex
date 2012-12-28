package com.threekindoms.client.events
{
	import flash.events.Event;

	public class LogEvent extends Event
	{
		public static const VIEW_LOG:String = "ViewLogEvent";

        private var _message:String;
        
        public function get message():String {
        	return this._message
        }

		public function LogEvent(message:String, bubbles:Boolean = true)
		{
			super(VIEW_LOG, bubbles);
			this._message = message;
		}

        override public function clone():Event {
        	return new LogEvent(message, this.bubbles);
        }
	}
}