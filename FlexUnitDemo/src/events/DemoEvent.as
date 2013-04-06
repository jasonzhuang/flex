package events {
    import flash.events.Event;

    public class DemoEvent extends Event {
        public static const DEMO:String = "demoEvent";

        public function DemoEvent(type:String, bubbles:Boolean = true) {
            super(type, bubbles);
        }

    }
}