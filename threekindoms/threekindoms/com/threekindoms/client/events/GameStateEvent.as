package com.threekindoms.client.events
{
	import flash.events.Event;

	public class GameStateEvent extends Event
	{
		public static const GAME_STATE:String = "gameState";
		
		public function GameStateEvent(message:String, bubbles:Boolean = true)
		{
			super(GAME_STATE, bubbles);
			this._message = message;
		}
		
        private var _message:String;
        
        public function get message():String {
            return this._message
        }

        override public function clone():Event {
            return new GameStateEvent(message, this.bubbles);
        }
	}
}