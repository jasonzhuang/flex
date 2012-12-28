package textDisplay {
    import flash.display.Sprite;

    import flash.text.*;
    /**
    * To create a text field with an expandable bottom border and a fixed
      width, set autoSize to anything but TextFieldAutoSize.NONE, and set
      wordWrap to true.
      Flash Player renders accurate rotation, skew, and transparency for text fields that use
      embedded fonts only
    */
    public class ExpandableText extends Sprite{
        public function ExpandableText() {
            var t:TextField = new TextField( );
            t.text = "Hello world, how are you?";
            t.background = true;
            t.backgroundColor = 0xCCCCCC;
            t.border = true;
            t.borderColor = 0x333333;
            // In combination, the following two lines make t's bottom border
            // automatically resize to accommodate t.text.
            t.autoSize = TextFieldAutoSize.LEFT;
            t.wordWrap = true;
            //by default, Flash Player renders all text fields at full opacity, even when they are
            //set to transparent via the TextField class’s instance variable alpha
            t.alpha = 0.2;
            //llow the user to enter line breaks
            t.multiline = true;
            t.displayAsPassword = true;
        }
    }
}