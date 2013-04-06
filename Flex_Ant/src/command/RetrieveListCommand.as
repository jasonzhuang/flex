package command {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    
    import delegates.RetrieveListDelegate;
    
    import events.RetrieveListEvent;
    
    import mx.controls.Alert;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    
    import shared.ResponderHelper;

    /**
    * refer MessageResponder and NetConnectionMessageResponder
    * NetConnection uses a Responder to handle result and status responses
    * from a remote endpoint
    *
    */
    public class RetrieveListCommand implements IResponder, ICommand {
//        private var targetModel:Object;
//        private var proName:String;
        private var callback:Function;

        public function execute(event:CairngormEvent):void {
            var retrieveEvent:RetrieveListEvent = RetrieveListEvent(event);

//            this.targetModel = retrieveEvent.model;
//            this.proName = retrieveEvent.proName;

            this.callback = retrieveEvent.callback;
            var delegate:RetrieveListDelegate = RetrieveListDelegate(getDelegate(RetrieveListDelegate));
            delegate.retrieveList();
        }

        public function result(data:Object):void {
            var re:ResultEvent = data as ResultEvent;

//            this.targetModel[this.proName] = re.result as Array;
            callback(re.result as Array);
        }

        public function fault(info:Object):void {
            var faultError:FaultEvent = info as FaultEvent;
            var execeptionMessage:String = getMessage(faultError);
            mx.controls.Alert.show(execeptionMessage);
        }

        private function getMessage(faultEvent:FaultEvent):String {
            return faultEvent.fault.faultString;
        }

        public function getDelegate(realDelegateClass:Class):Object {
            return ResponderHelper.getDelegate(realDelegateClass, this);
        }
    }
}