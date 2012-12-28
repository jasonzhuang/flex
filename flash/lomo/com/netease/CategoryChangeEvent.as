package com.netease {
	import flash.events.Event;
	
	public class CategoryChangeEvent extends Event {
		public static const CATEGORY_CHANGE:String = "categoryChange";
		
		private var _template:Template;
		
		public function get template():Template {
			return this._template;
		}
		
		public function CategoryChangeEvent(template:Template, bubbles:Boolean = true) {
			super(CATEGORY_CHANGE, bubbles);
			this._template = template;
		}
		
		override public function clone():Event {
			return new CategoryChangeEvent(this._template, this.bubbles);
		}

	}
	
}
