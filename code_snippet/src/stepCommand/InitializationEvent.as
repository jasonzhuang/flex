package stepCommand
{
	import flash.events.Event;
	
	public class InitializationEvent extends Event
	{
		public static const STEP_COMPLETED:String = "stepComplete";
		
		public static const INIT_COMPLETE:String = "initComplete";
		
		public function InitializationEvent(type:String, bubbles:Boolean=true)
		{
			super(type, bubbles);
		}
	}
}