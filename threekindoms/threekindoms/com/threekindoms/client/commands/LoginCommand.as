package com.threekindoms.client.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.threekindoms.client.cairngormevents.LoginRemoteEvent;
	
	import com.threekindoms.client.business.LoginDelegate;
	
	public class LoginCommand extends BaseCommand
	{
       override public function handleExecute(event:CairngormEvent):void {
        	var loginEvent:LoginRemoteEvent = event as LoginRemoteEvent;
        	var loginDelegate:LoginDelegate = new LoginDelegate();
        	loginDelegate.login(loginEvent.userName, loginEvent.password);
        }
	}
}