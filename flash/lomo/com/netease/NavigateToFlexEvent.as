package com.netease {
	import flash.events.Event;
	
	/**
	 *	NavigateToFlexEvent
	 */
	public class NavigateToFlexEvent extends Event {
		public static const NAV_TO_FLEX:String = "navigateToFlex";
		
		private var _templateId:String;
		private var _index:String;
		private var _from:String;
		
		public function get templateId():String {
			return this._templateId;
		}
		
		public function get index():String {
			return this._index;
		}
		
		public function get from():String {
			return this._from;
		}
		
		public function NavigateToFlexEvent(templateId:String, index:String, from:String="", bubbles:Boolean=true)
		{
			super(NAV_TO_FLEX, bubbles);
			this._templateId = templateId;
			this._index = index;
			this._from = from;
		}
		
		override public function clone():Event {
			return new NavigateToFlexEvent(this._templateId, this._index, this._from, this.bubbles);
		}
	}
}