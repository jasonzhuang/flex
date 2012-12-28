package com.threekindoms.client.events
{
    import flash.events.Event;

    public class ChangePlayerAttributesEvent extends Event
    {
        public static const CHANGE_PLAYER_ATTRIBUES:String = "changePlayerAttributes";

        private var _attribues:Array;
        private var _playerName:String;

        public function ChangePlayerAttributesEvent(playerAttributes:Array, playerName:String, bubbles:Boolean = true)
        {
            super(CHANGE_PLAYER_ATTRIBUES, bubbles);
            this._attribues = playerAttributes;
            this._playerName = playerName;
        }

        public function get attributes():Array {
            return this._attribues;
        }

        public function get playerName():String {
            return this._playerName;
        }

        override public function clone():Event {
            return new ChangePlayerAttributesEvent(this._attribues, this._playerName, this.bubbles);
        }
    }
}