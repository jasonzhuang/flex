package com.threekindoms.client.events
{
    import flash.events.Event;

    public class StartGameEvent extends Event
    {
        public static const STARTGAME:String = "startGame";

        private var _message:String;
        private var _players:Array;


        public function StartGameEvent(message:String, players:Array, bubbles:Boolean = true)
        {
            super(STARTGAME, bubbles);
            this._message = message;
            this._players = players;
        }

        public function get message():String
        {
            return this._message;
        }

        public function get players():Array {
            return this._players;
        }

        override public function clone():Event
        {
            return new StartGameEvent(this._message, this._players, this.bubbles);
        }
    }
}
