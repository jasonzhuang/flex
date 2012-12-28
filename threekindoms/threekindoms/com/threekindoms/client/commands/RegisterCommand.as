package com.threekindoms.client.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.threekindoms.client.business.RegisterDelegate;
	import com.threekindoms.client.cairngormevents.RegisterRemoteEvent;
	import com.threekindoms.client.vo.UserInfo;
	import com.threekindoms.client.utils.UserInfoFactory;
	
	public class RegisterCommand extends BaseCommand
	{
	    override public function handleExecute(event:CairngormEvent):void {
            var registerEvent:RegisterRemoteEvent = event as RegisterRemoteEvent;
            var registerDelegate:RegisterDelegate = new RegisterDelegate();
            registerDelegate.register(registerEvent.userInfo);
        }
	}
}