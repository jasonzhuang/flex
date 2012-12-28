package events {
    import flash.events.Event;

    public class RetrieveCompleteEvent extends Event {
        public static const COMPLETE:String = "retrieveComplete";

        public function RetrieveCompleteEvent(bubbles:Boolean = true) {
            super(COMPLETE, bubbles);
        }

    }
}