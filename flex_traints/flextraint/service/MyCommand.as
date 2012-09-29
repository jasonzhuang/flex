package service {
    import mx.rpc.IResponder;

    public class MyCommand implements IResponder {
        public function MyCommand() {
            
        }

        //data type is ResultEvent
        public function result(data:Object):void {
            trace("this is result() method");
        }

        public function fault(info:Object):void {
            
        }
    }
}