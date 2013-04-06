package shared {
    import flash.events.TimerEvent;
    import flash.utils.Dictionary;

    import mx.rpc.IResponder;
    import mx.rpc.events.ResultEvent;

    import mx.rpc.events.FaultEvent;

    public class ResponderHelper {
        private static var testDelegateMap:Dictionary = null;

        internal static function registerTestDelegate(testDelegateClass:Class,
                realDelegateClass:Class):void
        {
            if (!testDelegateMap) {
                testDelegateMap = new Dictionary();
            }

            testDelegateMap[realDelegateClass] = testDelegateClass;
        }

        public static function getDelegate(realDelegateClass:Class,
                responder:IResponder):Object
        {
            var resultDelegateClass:Class = realDelegateClass;

            if (testDelegateMap) {
                resultDelegateClass =
                        testDelegateMap[resultDelegateClass] == null
                                ? resultDelegateClass
                                : testDelegateMap[resultDelegateClass];
            }

            return new resultDelegateClass(responder);
        }

        public static const MOCKED_RESULT_DELAY_IN_MS:Number = 1500;

        public static function sendMockedAsyncResult(responder:IResponder, resultEvent:ResultEvent,
                faultEvent:FaultEvent = null, delay:Number = -1):void
        {
            if (delay < 0) {
                delay = MOCKED_RESULT_DELAY_IN_MS;
            }

            // if both set resultEvent and faultEvent, only execute faultEvent.
            if (delay == 0) {
                if (faultEvent) {
                    responder.fault(faultEvent);
                } else {
                    responder.result(resultEvent);
                }
            } else {
                var timer:MockedAsyncResultTimer = new MockedAsyncResultTimer(delay, 1);
                timer.responder = responder;
                timer.resultEvent = resultEvent;
                timer.faultEvent = faultEvent;
                timer.addEventListener(TimerEvent.TIMER, delayedMockedResultTimerHandler);
                timer.start();
            }
        }

        private static function delayedMockedResultTimerHandler(event:TimerEvent):void {
            var currentTimer:MockedAsyncResultTimer = event.target as MockedAsyncResultTimer;
            if (currentTimer) {
                if (currentTimer.faultEvent) {
                    currentTimer.responder.fault(currentTimer.faultEvent);
                } else {
                    currentTimer.responder.result(currentTimer.resultEvent);
                }
            }
        }
    }
}

import flash.utils.Timer;

import mx.rpc.IResponder;
import mx.rpc.events.ResultEvent;
import mx.rpc.events.FaultEvent;

class MockedAsyncResultTimer extends Timer {
    public var responder:IResponder;
    public var resultEvent:ResultEvent;
    public var faultEvent:FaultEvent;

    public function MockedAsyncResultTimer(delay:Number, repeatCount:int = 0) {
        super(delay, repeatCount);
    }

}