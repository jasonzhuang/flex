package com.threekindoms.client.events
{
	import flash.events.Event;

	public class OperationEvent extends Event
	{
		public static const OPERATION_RECEIVE:String = "OperationReceive";

        private var _operations:Array;

        public function OperationEvent(operations:Array, bubbles:Boolean = true) {
            super(OPERATION_RECEIVE, bubbles);
            this._operations = _operations;
        }

        public function get operations():Array {
            return this._operations;
        }

        override public function clone():Event {
            return new OperationEvent(this._operations, this.bubbles);
        }
	}
}