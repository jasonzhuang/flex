package presentmodel {
    import com.adobe.cairngorm.control.CairngormEventDispatcher;
    
    import events.RetrieveCompleteEvent;
    import events.RetrieveListEvent;
    
    import flash.events.IEventDispatcher;

    public class EmployeePM extends BasePresentModel{
        /**
        * If has no <code>ArrayElementType</code> metedata, the type is Object in resultEvent.result
        */
        [ArrayElementType("vo.Employee")]
        public var result:Array;

//        public function set remoteData(employees:Array):void {
//            this.result = employees;
//            this.dispatchEvent(new RetrieveCompleteEvent());
//        }
        //the callback function can be private
        private function setRemoteData(employees:Array):void {
            this.result = employees;
            this.dispatchEvent(new RetrieveCompleteEvent());
        }

        public function EmployeePM(dispatcher:IEventDispatcher) {
            super(dispatcher);
        }

        //use bound function instead of model
        public function retrieveList():void {
            var callback:Function = this.setRemoteData;
//            CairngormEventDispatcher.getInstance().dispatchEvent(
//                    new RetrieveListEvent(this, "remoteData"));
            CairngormEventDispatcher.getInstance().dispatchEvent(
                    new RetrieveListEvent(callback));
        }
    }
}