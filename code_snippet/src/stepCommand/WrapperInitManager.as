package stepCommand
{
	import flash.display.Stage;

	import mx.core.Application;
	
	public class WrapperInitManager extends InitManager
	{
		public function WrapperInitManager()
		{
			this.addStep(new UserInfoInitStep(), function():Object {
				return "name";
			});
			this.addStep(LookupDataInitStep());
		}
	}
}