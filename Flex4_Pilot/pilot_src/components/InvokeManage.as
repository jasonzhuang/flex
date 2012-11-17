package components
{
    import constants.EventNames;
    
    import events.DataNotifyEvent;
    
    import flash.events.EventDispatcher;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
	
    public class InvokeManage extends EventDispatcher
    {
        private static var DELAY:int = 1000;

        private var _executeCount:int;
        private var owner:Object;
        private var func:Function;
        private var timer:Timer;

        private var costTimes:Array;

        public function InvokeManage(func:Function, owner:Object, executeCount:int = 1)
        {
            this.func = func;
            this.owner = owner;
            this._executeCount = executeCount;
            costTimes = [];
        }

        public function get executeCount():int {
            return _executeCount;
        }

        public function execute():void {
            timer = new Timer(DELAY, executeCount);
            timer.addEventListener(TimerEvent.TIMER, onTimer);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, onComplete);
            timer.start();
        }

        private function onTimer(event:TimerEvent):void {
            var start:Number = getTimer();
            func.call(owner);
            var end:Number = getTimer();
            var elapse:Number = end - start;
            costTimes.push(elapse);
        }

        private function onComplete(event:TimerEvent):void {
            this.dispatchEvent(new DataNotifyEvent(EventNames.EXECUTE_COMPLETE));
        }

        public function get averageCost():Number {
            var total:Number = 0;
            for each (var cost:Number in costTimes) {
                total += cost;
            }
            return total/_executeCount;
        }

        public function dispose():void {
            timer.removeEventListener(TimerEvent.TIMER, onTimer);
        }

        private function getTimer():Number {
            return new Date().getTime();
        }

        public function executeAmount():int {
            return costTimes.length;
        }

    }
}