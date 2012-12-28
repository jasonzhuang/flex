package com.threekindoms.client.events
{
	import com.threekindoms.client.model.ViewType;
	
	import flash.events.Event;

	public class ViewToggleEvent extends Event
	{
		public static const VIEW_TOGGLE:String = "viewToggle";

        private var _viewType:ViewType;
        
        public function get viewType():ViewType {
        	return this._viewType;
        }

		public function ViewToggleEvent(viewType:ViewType, bubbles:Boolean = true)
		{
			super(VIEW_TOGGLE, bubbles);
            this._viewType = viewType;			
		}

        override public function clone():Event {
        	return new ViewToggleEvent(this.viewType, this.bubbles);
        }
		
	}
}