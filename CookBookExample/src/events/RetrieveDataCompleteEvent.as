package events {
    import flash.events.Event;

    public class RetrieveDataCompleteEvent extends Event {
        public static const COMPLETE:String = "retrieveComplete";

        public function RetrieveDataCompleteEvent(bubbles:Boolean = true) {
            super(COMPLETE, bubbles);
        }

        override public function clone():Event {
            return new RetrieveDataCompleteEvent(this.bubbles);
        }

    }
}