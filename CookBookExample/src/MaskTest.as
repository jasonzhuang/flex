package
{
    import flash.display.*;
    import flash.events.MouseEvent;
    import flash.text.*;
    public class MaskTest extends Sprite
    {
        private var square:Shape;
        private var tf:TextField;
        public function MaskTest() {
            tf = new TextField();
            tf.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, " 
                        + "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
            tf.selectable = false;
            tf.wordWrap = true;
            tf.width = 150;
            addChild(tf);

            square = new Shape();
            square.graphics.beginFill(0x0000FF);
            square.graphics.drawRect(0, 0, 40, 40);
            addChild(square);

            //the mask is not draw on the stage
            tf.mask = square;
            
//            tf.addEventListener(MouseEvent.MOUSE_DOWN, drag);
//            tf.addEventListener(MouseEvent.MOUSE_UP, noDrag);
        }

//        private function drag(event:MouseEvent):void {
//            square.startDrag();
//        }
//
//        private function noDrag(event:MouseEvent):void {
//            square.stopDrag();
//        }
    }
}