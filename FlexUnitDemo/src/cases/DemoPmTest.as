package cases {
    import events.DemoEvent;

    import flash.events.Event;

    import org.flexunit.Assert;
    import org.flexunit.async.Async;

    public class DemoPmTest {
        private var demoPm:DemoPm;

        /**
        * Notice:Cannot add asynchronous functionality
        * to methods defined by Test,Before or After that are not marked async
        */

        [Before(async)]
        public function setUp():void {
            demoPm = new DemoPm();
//            Async.proceedOnEvent(this, demoPm, DemoEvent.DEMO, 1500, null);
//            this.demoPm.retrieveDateDelegate();
        }

        [After(async)]
        public function tearDown():void {
            demoPm = null;
        }

        [Test(async)]
        public function testRetrieveData():void {
            var asyncHandler:Function =
                    Async.asyncHandler(this, handleRetrieveData, 1000, null, handleRetrieveDateTimeOut);
            //use weakReference
            this.demoPm.addEventListener(DemoEvent.DEMO, asyncHandler, false, 0, true);
            this.demoPm.retrieveDateDelegate();
        }

        private function handleRetrieveData(event:Event, passThroughDate:Object):void {
            Assert.assertEquals("Name1", this.demoPm.names[0]);
        }

        private function handleRetrieveDateTimeOut(passThroughDate:Object):void {
            Assert.fail("retrieve data timeout");
        }

        [Test]
        public function testRetrieveMockedData():void {
            Assert.assertEquals(1, this.demoPm.retrieveMockedData());
        }

    }
}