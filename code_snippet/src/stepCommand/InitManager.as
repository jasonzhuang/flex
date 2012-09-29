package stepCommand
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	public class InitManager extends EventDispatcher
	{
		private var processes:Array = [];
		
		private var paramFuncMap:Dictionary = new Dictionary();
		
		private var callerMap:Dictionary = new Dictionary();
		
		public function addStep(process:BaseInitStep, paramFunc:Function = null, caller:Object = null):void {
			processes.push(process);
			this.paramFuncMap[process]  = paramFunc;
			this.callerMap[process] = caller;
		}
		
		public function executeAll():void {
			executeNextStep();
		}
	
		private function doExecution(process:BaseInitStep):void {
			var paramFunc:Function = this.paramFuncMap[process];
			var stepParam:* = null;
			var caller:Object = this.callerMap[process];
			
			if(paramFunc != null) {
				stepParam = paramFunc.call(caller);
			}
			
			process.execute(stepParam);
		}
		
		internal function getProcesses():int {
			return processes.length;
		}
		
		private function handleCompleteStep(event:InitializationEvent):void {
			executeNextStep();
		}

		private function executeNextStep():void {
			if(this.getProcesses() <= 0) {
				this.initComplete();
				return;
			}
			
			var process:BaseInitStep = processes.shift() as BaseInitStep;
		
			process.addEventListener(InitializationEvent.STEP_COMPLETED, handleCompleteStep);
			
		    this.doExecution(process);
		}
		
		private function initComplete():void {
			this.dispatchEvent(new InitializationEvent(InitializationEvent.INIT_COMPLETE));
		}
	}
}