package com.threekindoms.client.services
{
	import com.electrotank.electroserver5.ElectroServer;
	import com.electrotank.electroserver5.ManagerHelper;
	import com.electrotank.electroserver5.api.EsMessage;
	import com.electrotank.electroserver5.connection.Connection;
	import com.threekindoms.client.errors.SingletonError;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	public class ElectroServerService implements IEventDispatcher
	{
		private static var instance:ElectroServerService;
        private static var server:ElectroServer;

		public function ElectroServerService() {
			if (instance != null) {
				throw new SingletonError("Singleton error");
			}
			instance = this;
		}

        public static function getInstance():ElectroServerService {
        	if(!instance) {
        		instance = new ElectroServerService();
        		server = new ElectroServer();
        	}
        	return instance;
        }

        public function loadAndConnect(fileName:String):void {
            server.loadAndConnect(fileName);
        }

        public function get managerHelper():ManagerHelper {
        	return server.managerHelper;
        }

        public function send(message:EsMessage, con:Connection = null):void {
        	server.engine.send(message, con);
        }

        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
        	server.engine.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }
        
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
        	server.engine.removeEventListener(type, listener, useCapture);
        }
        
        public function dispatchEvent(event:Event):Boolean {
        	return server.engine.dispatchEvent(event);
        }
        
        public function hasEventListener(type:String):Boolean {
        	return server.engine.hasEventListener(type);
        }

        public function willTrigger(type:String):Boolean {
        	return server.engine.willTrigger(type);
        }
	}
}