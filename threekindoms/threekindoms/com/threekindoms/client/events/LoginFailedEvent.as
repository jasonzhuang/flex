package com.threekindoms.client.events
{
	import flash.events.Event;

	public class LoginFailedEvent extends Event
	{
		public static const LOGIN_FAILED:String = "LoginFailed";

        private var _message:String;

        public function get message():String {
            return this._message;
        }

		public function LoginFailedEvent(message:String, bubbles:Boolean=true)
		{
			super(LOGIN_FAILED, bubbles);
			this._message = message;
		}

        override public function clone():Event {
        	return new LoginFailedEvent(this.message, this.bubbles);
        }
		
	}
}