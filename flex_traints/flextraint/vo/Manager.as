package vo
{
    public class Manager extends Employee {
        public function drink():void {
            eat();
            trace("drink....")
        }

        //static function can't be override
//        override public static function eat():void {
//            
//        }
    }
}