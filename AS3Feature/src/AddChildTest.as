package
{
    import flash.display.Sprite;

    public class AddChildTest extends Sprite
    {
        public function AddChildTest() {
            var container:Sprite = new Sprite();

            var circle1:Sprite = new Sprite();
            var circle2:Sprite = new Sprite();

            circle1.graphics.beginFill(0x00FF00);
            circle1.graphics.drawCircle(40,40,50);

            circle2.graphics.beginFill(0X0000FF);
            circle2.graphics.drawCircle(40,40,30);

            container.addChild(circle1);//depth = 0
            container.addChild(circle2);//depth =1

            //the big depth will overlap the small depth
            
            this.addChild(container);
        }
    }
}