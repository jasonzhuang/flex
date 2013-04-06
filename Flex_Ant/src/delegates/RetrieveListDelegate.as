package delegates {
    import com.adobe.cairngorm.business.ServiceLocator;

    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.remoting.RemoteObject;

    import service.Service;

    public class RetrieveListDelegate {
        private var _employeeService:RemoteObject;

        protected var responder:IResponder;

        public function get employeeService():RemoteObject {
            if (this._employeeService == null) {
                this._employeeService = ServiceLocator.getInstance().getRemoteObject(
                        Service.RETRIEVE_EMPLOYEE);
            }

            return this._employeeService;
        }

        public function RetrieveListDelegate(responder:IResponder) {
            this.responder = responder;
        }

        public function retrieveList():void {
            //Handling events at the call level, use AysncToken
            var caller:AsyncToken = this.employeeService.getEmployees();
            caller.addResponder(responder);
        }
    }
}