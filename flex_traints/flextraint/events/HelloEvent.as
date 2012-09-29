package events {
    import flash.events.Event;

    public class HelloEvent extends Event {
        public static const HELLO:String = "Hello";

        public function HelloEvent(type:String, bubbles:Boolean = true):void {
            super(HELLO, bubbles);
        }

    }
}