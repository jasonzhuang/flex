package test
{
	import control.WrapperController;
	
	import delegates.*;
	
	import events.RetrieveCompleteEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import presentmodel.EmployeePM;
	
	import shared.*;

    public class EmployeePmTest {
        private var pm:EmployeePM;

        [BeforeClass]
        public static function prepare():void {
            FrontControllerHelper.registerFrontController(WrapperController);
            TestDelegateHelper.registerTestDelegate(MockedRetrieveListDelegate, RetrieveListDelegate);
        }

        [Before]
        public function setUp():void {
            this.pm = new EmployeePM(new EventDispatcher());
        }

        [After]
        public function tearDown():void {
            this.pm = null;
        }

        [Test(async)]
        public function testGetEmployees():void {
            var async:Function = Async.asyncHandler(this, varifyResult, 5000);
            this.pm.addEventListener(RetrieveCompleteEvent.COMPLETE, async);
            this.pm.retrieveList();
        }

        private function varifyResult(event:Event, data:Object):void {
            Assert.assertNotNull(this.pm.result);
        }

    }
}