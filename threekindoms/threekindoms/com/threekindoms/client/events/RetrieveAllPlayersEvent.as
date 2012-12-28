package com.threekindoms.client.events
{
    import flash.events.Event;

    public class RetrieveAllPlayersEvent extends Event
    {
        public static const TYPE:String = "retrieveAllPlayers";

        private var _players:Array;

        public function get players():Array {
            return this._players;
        }

        public function RetrieveAllPlayersEvent(players:Array, bubbles:Boolean = true)
        {
            super(TYPE, bubbles);
            this._players = players;
        }

        override public function clone():Event {
            return new RetrieveAllPlayersEvent(this._players, this.bubbles);
        }
    }
}