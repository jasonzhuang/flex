package delegates
{
	import mx.rpc.events.ResultEvent;
	import mx.rpc.IResponder;
	import vo.Employee;
    import shared.ResponderHelper;

	public class MockedRetrieveListDelegate extends RetrieveListDelegate {
        public function MockedRetrieveListDelegate(responder:IResponder) {
            super(responder);
        }

        override public function retrieveList():void {
            var employees:Array = getEmployees();
            var resultEvent:ResultEvent = new ResultEvent(ResultEvent.RESULT, false, true, employees);
            ResponderHelper.sendMockedAsyncResult(responder, resultEvent);
        }

        private function getEmployees():Array {
            var result:Array = [];
            for (var i:int = 0; i<8; i++) {
                var employee:Employee = new Employee();
                employee.id = i;
                employee.name = i.toString();
                result.push(employee);
            }
            return result;
        }
    }
}