package view {

    import flash.events.Event;

    import mx.events.FlexEvent;

    import org.flexunit.Assume;
    import org.flexunit.async.Async;
    import org.fluint.uiImpersonation.UIImpersonator;

    import event.ToggleEvent;

    public class ToggleHelperTestBase {

        private var _container:ToggleContainer;

        public function get container():ToggleContainer {
            return this._container;
        }

        public function prepare(container:ToggleContainer):void {
            this._container = container;
            UIImpersonator.addChild(this.container);
            Async.proceedOnEvent(this, this.container, ToggleEvent.TOGGLE_COMPLETE, 1000);

            Assume.assumeTrue(!this.container.getPage(0).existed);
            Assume.assumeTrue(!this.container.getPage(1).entered);
        }

        public function startToggle():void {
            this.container.startToggle(this.container.getPage(1));
        }

        [After(async, ui)]
        public function tearDown():void {
            UIImpersonator.removeChild(this.container);
            this._container = null;
        }
    }
}