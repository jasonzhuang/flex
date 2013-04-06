package cases {
    import events.DemoEvent;

    import flash.events.EventDispatcher;

    public class DemoPm extends EventDispatcher {
        private var _names:Array = null;

        public function get names():Array {
            return this._names;
        }

        public function retrieveDateDelegate():void {
            this._names = ["Name1", "Name2", "Name3"];
            this.dispatchEvent(new DemoEvent(DemoEvent.DEMO));
        }

        public function retrieveMockedData():Number {
            return 1;
        }
    }
}