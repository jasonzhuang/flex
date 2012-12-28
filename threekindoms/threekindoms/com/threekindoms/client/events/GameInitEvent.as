package com.threekindoms.client.events
{
	import com.threekindoms.client.vo.GameInfo;
	
	import flash.events.Event;

	public class GameInitEvent extends Event
	{
		public static const GAME_INIT:String = "GameInit";
		
		private var _gameInfo:GameInfo;
		
		public function GameInitEvent(gameInfo:GameInfo, bubbles:Boolean = true) {
			super(GAME_INIT, bubbles);
            this._gameInfo = gameInfo;			
		}

        public function get gameInfo():GameInfo {
        	return this._gameInfo;
        }

        override public function clone():Event {
        	return new GameInitEvent(this.gameInfo, this.bubbles);
        }
	}
}