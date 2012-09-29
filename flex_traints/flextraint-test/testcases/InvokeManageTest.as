package testcases
{
    import components.InvokeManage;

    import events.ExecuteCompleteEvent;

    import flash.events.Event;

    import org.flexunit.Assert;
    import org.flexunit.async.Async;

    public class InvokeManageTest
    {
        private var dummy:InvokeStub;
        private var invokeManage:InvokeManage;

        [Before]
        public function setUp():void {
            dummy = new InvokeStub();
            invokeManage = new InvokeManage(dummy.dummyFunction, dummy, 2);
        }

        [After]
        public function tearDown():void {
            dummy = null;
            invokeManage.dispose();
            invokeManage = null;
        }

        [Test(async)]
        public function testInvokeTwice():void
        {
            var func:Function = dummy.dummyFunction;
            var async:Function = Async.asyncHandler(this, executeComplete, 5000, null, null);
            invokeManage.addEventListener(ExecuteCompleteEvent.EXECUTE_COMPLETE, async);
            invokeManage.execute();
        }

        private function executeComplete(event:Event, data:Object):void {
            Assert.assertEquals(2, invokeManage.executeAmount());
        }
    }
}

class InvokeStub {
    public function dummyFunction():void {
        trace("execute");
    }
}
