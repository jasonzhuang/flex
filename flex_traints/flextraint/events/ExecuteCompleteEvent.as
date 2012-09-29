package events
{
    import flash.events.Event;

    public class ExecuteCompleteEvent extends Event
    {
        public static const EXECUTE_COMPLETE:String = "executeComplete";

        public function ExecuteCompleteEvent(bubbles:Boolean = true) {
            super(EXECUTE_COMPLETE, bubbles);
        }

        override public function clone():Event {
            return new ExecuteCompleteEvent(bubbles);
        }
    }
}