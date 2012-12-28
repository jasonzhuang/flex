package com.threekindoms.client.events
{
	import com.threekindoms.client.vo.OperationInfo;
	
	import flash.events.Event;

	public class OperationReceiveEvent extends Event
	{
		public static const OPERATION_RECEIVE:String = "OperationReceive";

        private var _operationInfo:OperationInfo;

        public function OperationReceiveEvent(operationInfo:OperationInfo, bubbles:Boolean = true) {
        	super(OPERATION_RECEIVE, bubbles);
        	this._operationInfo = operationInfo;
        }

        public function get operationInfo():OperationInfo {
        	return this._operationInfo;
        }

        override public function clone():Event {
        	return new OperationReceiveEvent(this.operationInfo, this.bubbles);
        }
	}
}