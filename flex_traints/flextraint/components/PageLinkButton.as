package components
{
    import mx.controls.Label;

    /**
    * PageLinkButton used for display a set of page numbers and navigate to given page
    */
    public class PageLinkButton extends Label {
        private var _selected:Boolean = false;


        public function PageLinkButton() {
            super();
            this.buttonMode = true;
            this.useHandCursor = true;
            this.mouseChildren = false;
        }

        [Bindable]
        public function set selected(value:Boolean):void {
            this._selected = value;
        }

        public function get selected():Boolean {
            return this._selected;
        }

        /**
        * make the protected property "textField" visible, so can change backgroundColor
        */
        public function getTextField():* {
              return textField;
        }
    }
}