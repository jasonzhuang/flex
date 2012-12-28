package com.threekindoms.client.events
{
	import flash.events.Event;
	public class RegisterFailedEvent extends Event
	{
		public static const REGISTER_FAILED:String = "registerFailed";
		private var _message:String;

        public function get message():String {
        	return this._message;
        }

		public function RegisterFailedEvent(message:String, bubbles:Boolean=true)
		{
			super(REGISTER_FAILED, bubbles);
			this._message = message;
		}
		
		override public function clone():Event {
			return new RegisterFailedEvent(this.message, this.bubbles);
		}
	}
}