package cases {
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import flexunit.framework.AssertionFailedError;

    import org.flexunit.Assert;
    import org.flexunit.async.Async;

    public class AsynTest {
        protected var timer:Timer;
        protected static var SHORT_TIME:int = 30;
        protected static var LONG_TIME:int = 500;

        [Before]
        public function setUp():void {
            timer = new Timer( LONG_TIME, 1 );
        }

        [After]
        public function tearDown():void {
            if ( timer ) {
                timer.stop();
            }

            timer = null;
        }

        //the test sequence is random

        [Test(async)]
        public function testInTimePass() : void {
            //We fire in SHORT_TIME mills, but are willing to wait LONG_TIME
            timer.delay = SHORT_TIME;
            //NOTICE:Async can only used in tests marked as [Test(async)]
            var async:Function = Async.asyncHandler(this, handleAsyncShouldPass, LONG_TIME, null,
                    handleAsyncShouldNotFail);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, async, false, 0, true );
            timer.start();
        }

        [Test(async)]
        public function testInTimeFail() : void {
            //We fire in SHORT_TIME mills, but are willing to wait LONG_TIME
            timer.delay = SHORT_TIME;
            var async:Function = Async.asyncHandler(this, handleAsyncShouldPassCallFail, LONG_TIME, null,
                    handleAsyncShouldNotFail )
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, async, false, 0, true );
            timer.start();
        }

        private function handleAsyncShouldPass(event:Event, passThroughData:Object ):void {
            for (var i:int = 0; i<5; i++) {
                var j:int = 0;
            }
            Assert.assertTrue(true);
        }

        private function handleAsyncShouldNotFail( passThroughData:Object ):void {
            Assert.fail('Timeout Reached Incorrectly');
        }

        protected function handleAsyncShouldPassCallFail( event:Event, passThroughData:Object ):void {
            try {
                Assert.fail();
            } catch (expected:AssertionFailedError) {
                //DO NOTHING
            }
        }

        [Test]
        public function testForFun():void {
            for (var i:int =0; i<10; i++) {
                var j:int = 0;
                j++;
            }
            Assert.assertEquals(1,1);
        }
    }
}