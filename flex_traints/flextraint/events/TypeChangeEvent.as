package events {
    import flash.events.Event;

    public class TypeChangeEvent extends Event {
        public static const TYPECHANGE:String = "typeChange";
        public var targetType:int;

        public function TypeChangeEvent(targetType:int, bubbles:Boolean = true) {
            super(TYPECHANGE, bubbles);
            this.targetType = targetType;
        }

    }
}