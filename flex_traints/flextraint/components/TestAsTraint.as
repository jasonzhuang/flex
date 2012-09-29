package components {
    import flash.display.Sprite;

    //class can't define as static
    //接口不能声明static const 变量
    public class TestAsTraint extends Sprite{

        //不支持方法重载，参数个数不同编译错误，返回类型不同也错误
        //不支持多个构造方法, 可以给构造方法默认值就能满足

        private var param:Object;
        private var temp:Function;

        //constructor modifier can only be public 
        public function TestAsTraint() {
            
        }

        // can't declare multi constructor
/*         public function TestAsTraint(i:int) {
            
        } */

        private function hello():String {
            trace("test function");
            return "hello";
        }
/*         public function addOne(item:Object):Boolean {
            
        } */
        //================error=========================//
       /*  public function addOne(item:Object, index:int):Boolean {
            
        } */

        //===================error======================//
/*         public function addOne(item:Object):void {
            
        } */

        //实现接口时方法签名必须一致，有默认值，则实现类也必须有默认值
        public function getSomeThing(index : int = 0):Object {
            return null;
        }

/*         public function testStage():void {
            trace(stage);
        } */

        public function testFunction():String {
            temp = hello;
            param = temp();//call hello() method
            return param.toString();
        }
    // classes must not be nested
/*       class B {
        
    }  */
}
}

//class can define outside the package declare
class C {
    
}
