package events {
    import com.adobe.cairngorm.control.CairngormEvent;

    public class RetrieveListEvent extends CairngormEvent {
        public static const RETRIEVE_LIST:String = "events.RetrieveListEvent";

//        private var _model:Object;
//        private var _proName:String;
//
//        public function get model():Object {
//            return this._model;
//        }
//
//        public function get proName():String {
//            return this._proName
//        }

//        public function RetrieveListEvent(model:Object, proName:String) {
//            super(RETRIEVE_LIST);
//            this._model = model;
//            this._proName = proName;
//        }

        private var _callback:Function;

        public function get callback():Function {
            return this._callback;
        }

        public function RetrieveListEvent(callback:Function) {
            super(RETRIEVE_LIST);
            this._callback = callback;
        }
        
    }
}