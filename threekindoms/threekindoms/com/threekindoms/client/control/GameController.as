package com.threekindoms.client.control
{
	import com.adobe.cairngorm.control.FrontController;
    import com.threekindoms.client.cairngormevents.LoginRemoteEvent;
    import com.threekindoms.client.cairngormevents.RegisterRemoteEvent;
    import com.threekindoms.client.commands.LoginCommand;
    import com.threekindoms.client.commands.RegisterCommand;    

    import com.threekindoms.client.commands.LoginCommand;

	public class GameController extends FrontController
	{
		public function GameController()
		{
			super();
			addCommands();
		}

        private function addCommands():void {
        	this.addCommand(LoginRemoteEvent.LOGIN, LoginCommand);
            this.addCommand(RegisterRemoteEvent.REGISTER, RegisterCommand);
        }
		
	}
}