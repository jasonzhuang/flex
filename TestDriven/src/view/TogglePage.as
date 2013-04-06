package view {

    import flash.utils.Dictionary;

    import mx.core.Container;

    public class TogglePage extends Container implements IPage {

        public function prepareExit(context:Dictionary):Boolean {
            return true;
        }

        private var _existed:Boolean = false;

        public function get existed():Boolean {
            return this._existed;
        }

        public function exit(context:Dictionary):void {
            this._existed = true;
            return;
        }

        public function prepareEnter(context:Dictionary):Boolean {
            return true;
        }

        private var _entered:Boolean = false;

        public function get entered():Boolean {
            return this._entered;
        }

        public function enter(context:Dictionary):void {
            this._entered = true;
            return;
        }

        public function confirmExit(context:Dictionary):ToggleConfirmResult {
            return ToggleConfirmResult.SUCCESSED;
        }

        public function confirmEnter(context:Dictionary):ToggleConfirmResult {
            return ToggleConfirmResult.SUCCESSED;
        }

        public function reenter(context:Dictionary):void {
            return;
        }
    }
}