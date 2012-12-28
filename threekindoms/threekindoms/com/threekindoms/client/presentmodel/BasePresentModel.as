package com.threekindoms.client.presentmodel {
    import flash.events.Event;
    import flash.events.IEventDispatcher;

    public class BasePresentModel implements IEventDispatcher {
        private var _eventDispatcher:IEventDispatcher;

        public function BasePresentModel(eventDispatcher:IEventDispatcher) {
            if(!eventDispatcher) {
                throw new Error("dispatcher can't be null");
            }
            this._eventDispatcher = eventDispatcher;
        }

        public function dispatchEvent(event:Event):Boolean {
            return this._eventDispatcher.dispatchEvent(event);
        }

        public function addEventListener(type:String, listener:Function,
                useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
        {
            this._eventDispatcher.addEventListener(type, listener,
                    useCapture, priority, useWeakReference);
        }

        public function removeEventListener(type:String, listener:Function,
                useCapture:Boolean  = false):void
        {
            this._eventDispatcher.removeEventListener(type, listener, useCapture);
        }

        public function hasEventListener(type:String):Boolean {
            return this._eventDispatcher.hasEventListener(type);
        }

        public function willTrigger(type:String):Boolean {
            return this._eventDispatcher.willTrigger(type);
        }
    }
}