package components
{
    import mx.controls.Label;

    public class IdRenderer extends Label {
        private var eId:String;

        override public function set data(value:Object):void {
            if (value == this.data) {
                return;
            }

            super.data = value;

            this.eId = value ? value.id : "";

            this.text = eId;
        }
    }
}