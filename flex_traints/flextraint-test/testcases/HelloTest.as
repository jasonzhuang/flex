package testcases {
    import events.HelloEvent;

    import org.flexunit.async.Async;

    import pm.HelloPm;

    public class HelloTest {
        [Test(async)]
        public function testHello():void {
            var helloPm:HelloPm = new HelloPm();
            //if eventName event not fires, test fail, otherwise test successful
            Async.proceedOnEvent(this, helloPm, HelloEvent.HELLO, 500);
            helloPm.hello();
        }

    }
}