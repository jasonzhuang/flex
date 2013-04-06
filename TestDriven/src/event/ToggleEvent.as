
package event {

    import flash.events.Event;

    /**
    * Events dispatched during page toggling.
    */
    public class ToggleEvent extends Event {

        /** Toggle process completed */
        public static const TOGGLE_COMPLETE:String = "toggle_complete";

        /**
        * Constructor
        */
        public function ToggleEvent(type:String,
                bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
        }

        /**
        * Clone the current event
        */
        override public function clone():Event {
            return new ToggleEvent(this.type, this.bubbles, this.cancelable);
        }
    }
}