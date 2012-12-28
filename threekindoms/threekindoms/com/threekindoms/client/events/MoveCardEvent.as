package com.threekindoms.client.events
{
	import flash.events.Event;

	public class MoveCardEvent extends Event
	{
		public static const MOVE_CARD:String = "moveCard";

        private var _cards:Array;

        public function MoveCardEvent(cards:Array, bubbles:Boolean = true) {
            super(MOVE_CARD, bubbles);
            this._cards = cards;
        }

        public function get cards():Array {
            return this._cards;
        }

        override public function clone():Event {
            return new MoveCardEvent(this._cards, this.bubbles);
        }
	}
}