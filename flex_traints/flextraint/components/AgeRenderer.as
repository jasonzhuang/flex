package components
{
    import mx.controls.Label;

    public class AgeRenderer extends Label
    {
        private var age:String;

        override public function set data(value:Object):void {
            if (value == this.data) {
                return;
            }

            super.data = value;

            this.age = value ? value.age : "";

            this.text = age;
        }
    }
}