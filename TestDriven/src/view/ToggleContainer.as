package view {

    import flash.utils.Dictionary;
    
    import mx.containers.VBox;
    import mx.containers.ViewStack;
    import mx.core.Container;

    public class ToggleContainer extends VBox implements IPageContainer {

        private var _pages:Array;

        private var _pageStack:ViewStack;

        private var toggleHelper:ToggleHelper = new ToggleHelper(this as IPageContainer);

        public function ToggleContainer(pages:Array) {
            super();

            this._pages = pages;
        }

        override protected function createChildren():void {
            super.createChildren();

            this._pageStack = new ViewStack();

            for each (var page:Container in this._pages) {
                this._pageStack.addChild(page);
            }

            this.addChild(this._pageStack);
        }

        public function get currentPage():IPage {
            return this._pageStack ? this._pageStack.selectedChild as IPage : null;
        }

        public function get pages():Array {
            return this._pages;
        }

        public function getPage(index:int):TogglePage {
            return this._pages[index] as TogglePage;
        }

        public function startToggle(page:IPage):void {
            this.toggleHelper.startToggle(page);
        }

        public function processToggle(newPage:IPage, context:Dictionary):void {
            this._pageStack.selectedChild = newPage as Container;
        }
    }
}