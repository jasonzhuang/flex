

package view {

    import flash.events.Event;
    import flash.utils.Dictionary;

    import event.ToggleEvent;

    /**
    * ToggleHelper can help a page container process the toggling workflow and maintain the context
    * during the process.
    * 
    * And the page container must implement IPageContainer interface, and pages in page container
    * must implement IPage interface.
    */
    public class ToggleHelper {

        private var container:IPageContainer;

        private var newPage:IPage = null;

        /**
        * The page currently displayed in page container.
        */
        public function get currentPage():IPage {
            return this.container.currentPage;
        }

        private var _context:Dictionary = new Dictionary();

        /**
        * Context information object shared during the toggling process.
        */
        public function get context():Dictionary {
            return this._context;
        }

        /**
        * Construct a ToggleHelper for the input page container.
        */
        public function ToggleHelper(toggleContainer:IPageContainer) {
            //ParamUtil.checkNull(toggleContainer, "toggleContainer");

            this.container = toggleContainer;
        }

        /**
        * Entrance of the toggling process.
        * 
        * @param newPage the page which the application toggle to.
        */
        public function startToggle(newPage:IPage):void {
            this.newPage = newPage;

            if (this.currentPage) {
                if (this.currentPage.prepareExit(context)) {
                    this.currentPage.exit(context);
                } else {
                    this.container.addEventListener(Event.ENTER_FRAME, this.waitForExitConfirm);
                    return;
                }
            }

            this.processNewPage();
        }

        private function waitForExitConfirm(event:Event):void {
            if (!this.currentPage) {
                this.container.removeEventListener(Event.ENTER_FRAME, this.waitForExitConfirm);
                return;
            }

            var result:ToggleConfirmResult = this.currentPage.confirmExit(this.context);

            switch (result) {
                case ToggleConfirmResult.SUCCESSED:
                    this.container.removeEventListener(Event.ENTER_FRAME, this.waitForExitConfirm);
                    this.currentPage.exit(context);

                    this.processNewPage();
                    return;
                case ToggleConfirmResult.WAIT:
                    return;
                case ToggleConfirmResult.FAILED:
                    this.container.removeEventListener(Event.ENTER_FRAME, this.waitForExitConfirm);
                    this.currentPage.reenter(context);
                    this.container.dispatchEvent(new ToggleEvent(ToggleEvent.TOGGLE_COMPLETE));
                    return;
                default:
                    throw new Error("Unsupport result: " + result);
            }
        }

        private function processNewPage():void {
            if (this.newPage) {
                if (this.newPage.prepareEnter(context)) {
                    this.newPage.enter(context);
                } else {
                    this.container.addEventListener(Event.ENTER_FRAME, this.waitForEnterConfirm);
                    return;
                }
            }

            this.container.processToggle(this.newPage, this.context);

            this.container.dispatchEvent(new ToggleEvent(ToggleEvent.TOGGLE_COMPLETE));
        }

        private function waitForEnterConfirm(event:Event):void {
            if (!this.newPage) {
                this.container.removeEventListener(Event.ENTER_FRAME, this.waitForEnterConfirm);
                return;
            }

            var result:ToggleConfirmResult = this.newPage.confirmEnter(this.context);

            switch (result) {
                case ToggleConfirmResult.SUCCESSED:
                    this.container.removeEventListener(Event.ENTER_FRAME, this.waitForEnterConfirm);
                    this.newPage.enter(this.context);
                    this.container.processToggle(this.newPage, this.context);

                    this.container.dispatchEvent(new ToggleEvent(ToggleEvent.TOGGLE_COMPLETE));

                    return;
                case ToggleConfirmResult.WAIT:
                    return;
                case ToggleConfirmResult.FAILED:
                    this.container.removeEventListener(Event.ENTER_FRAME, this.waitForExitConfirm);
                    if (this.currentPage) {
                        this.currentPage.reenter(context);
                    }
                    this.container.dispatchEvent(new ToggleEvent(ToggleEvent.TOGGLE_COMPLETE));
                    return;
                default:
                    throw new Error("Unsupport result: " + result);
            }
        }
    }
}