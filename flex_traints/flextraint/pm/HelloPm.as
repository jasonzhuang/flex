package pm {
    import flash.events.EventDispatcher;

    import events.HelloEvent;

    public class HelloPm extends EventDispatcher {

        public function hello():void {
            this.dispatchEvent(new HelloEvent(HelloEvent.HELLO));
        }
    }
}